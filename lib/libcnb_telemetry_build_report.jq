# This script processes OpenTelemetry JSON objects from a JSONL file,
# analyzes specific spans related to the .NET CNB build process, and
# produces a consolidated YAML key-value summary for the build system.

def get_attr($key_name):
  .attributes?
  | map(select(.key == $key_name) | .value | (.stringValue // .intValue // .boolValue))
  | first;

def duration_ns:
  (.endTimeUnixNano | tonumber) - (.startTimeUnixNano | tonumber);

def has_name($expected_name):
  .name == $expected_name;

def has_namespace($expected_namespace):
  get_attr("code.namespace") == $expected_namespace;

def increment_counter($current_value):
  ($current_value // 0) + 1;

def process_span_by_type($summary):
  if has_name("libcnb-build") then
    $summary + {
      libcnb_build_event: (.events[0]? | .name),
      libcnb_build_status_code: .status.code,
      libcnb_build_duration_ns: duration_ns,
      libcnb_build_error: (.events[0]? | get_attr("error"))
    }
  elif has_name("resolve_sdk_artifact") then
    $summary + {
      sdk_version_requirement: get_attr("cnb.dotnet.version_requirement")
    }
  elif has_namespace("buildpack_heroku_dotnet::layers::sdk") then
    if has_name("handle") then
      $summary + { sdk_layer_duration_ns: duration_ns }
    elif has_name("download_file") then
      $summary + {
        sdk_download_file_url: get_attr("url.full"),
        sdk_download_file_duration_ns: duration_ns,
        sdk_download_file_attempts: increment_counter($summary.sdk_download_file_attempts)
      }
    elif has_name("verify_checksum") then
      $summary + { sdk_verify_checksum_duration_ns: duration_ns }
    elif has_name("extract_tarball") then
      $summary + { sdk_extract_tarball_duration_ns: duration_ns }
    else $summary
    end
  else
    $summary
  end;

# Formats the complete report summary into YAML format
def format_report:
  to_entries
  | map(select(.value != null))
  | map("\(.key): \(.value | if type == "string" then "'\(.)'" else tostring end)")
  | join("\n");

# Extract all spans from all JSON objects in the slurped array
def extract_all_spans:
  .[] | .resourceSpans[]?.scopeSpans[]?.spans[]? // empty;

# Process all spans and generate the `bin/report` output
reduce extract_all_spans as $span (
  {}; # Initialize with empty summary
  . as $summary | $span | process_span_by_type($summary)
)
| format_report
