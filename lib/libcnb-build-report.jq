# This script processes a stream of OpenTelemetry JSON objects from a JSONL
# file, analyzes specific spans related to the CNB build process, and prints
# a single, consolidated key-value summary.

# Extracts an attribute value from a span's attributes
def get_attr($key_name):
  .attributes? | map(select(.key == $key_name) | .value | (.stringValue // .intValue // .boolValue)) | first;

# Calculates the duration of a span
def duration_ns:
  ((.endTimeUnixNano | tonumber) - (.startTimeUnixNano | tonumber));

# Takes a span and the current summary, returning an updated summary with the final key names.
def process_span($span; $summary):
  if $span.name == "libcnb-build" then
    $summary + {
      libcnb_build_event: ($span.events[0]?.name // null),
      libcnb_build_status_code: $span.status.code,
      libcnb_build_duration_ns: ($span | duration_ns),
      libcnb_build_error: ($span.events[0]? | get_attr("error"))
    }
  elif $span.name == "resolve_sdk_artifact" then
    $summary + { sdk_version_requirement: ($span | get_attr("cnb.dotnet.version_requirement")) }
  # Match the SDK layer's 'handle' span by its unique code namespace.
  elif $span.name == "handle" and ($span | get_attr("code.namespace") == "buildpack_heroku_dotnet::layers::sdk") then
    $summary + { sdk_layer_duration_ns: ($span | duration_ns) }
  elif $span.name == "download_file" then
    # Overwrite URL/duration with the latest attempt and increment the attempts counter.
    $summary + {
      sdk_download_url: ($span | get_attr("url.full")),
      sdk_download_duration_ns: ($span | duration_ns),
      sdk_download_attempts: (($summary.sdk_download_attempts // 0) + 1)
    }
  elif $span.name == "verify_checksum" then
    $summary + { sdk_verify_duration_ns: ($span | duration_ns) }
  elif $span.name == "extract_tarball" then
    $summary + { sdk_extract_duration_ns: ($span | duration_ns) }
  else
    $summary
  end;

def format_report:
  # Convert the object to an array of key-value strings.
  to_entries
  # Filter out any keys that have null values.
  | map(select(.value != null))
  # Format each remaining key-value pair into a "key: 'value'" or "key: value" string.
  | map(
      if (.value | type) == "string" then
        "\(.key): '\(.value)'"
      else
        "\(.key): \(.value)"
      end
    )
  # Join the formatted lines for bin/report
  | join("\n");

# Use `reduce` to process all spans from the file into a single summary object.
reduce (.resourceSpans[].scopeSpans[].spans[]) as $span (
  {}; # Initialize with an empty object.
  process_span($span; .)
)
# Format summary into bin/report compatible output
| format_report
