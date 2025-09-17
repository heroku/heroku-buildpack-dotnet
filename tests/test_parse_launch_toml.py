import os
import subprocess
import tempfile
import textwrap
import unittest
from pathlib import Path

SCRIPT_PATH = Path(__file__).resolve().parent.parent / "lib/parse_launch_toml.py"

# The TOML content used for all tests.
TEST_TOML_CONTENT = textwrap.dedent("""\
    # Current CNB output (used by bin/release and bin/detect)
    [[processes]]
    type = "bash-c"
    command = ["bash", "-c", "cd bin/publish; ./foo --urls http://*:$PORT"]

    [[processes]]
    type = "bash-c-spaces"
    command = ["bash", "-c", "cd 'console app/bin/publish'; ./'console app'"]

    [[processes]]
    type = "simple"
    command = ["dotnet", "test", "foo.csproj"]

    [[processes]]
    type = "simple-arg-spaces"
    command = ["dotnet", "test", "solution with spaces.sln"]

    # TOML parsing edge cases
    [[processes]]
    default = true
    command = ["foo", "bar", "baz", "qux", "quux"]
    type = "field-order"

    [[processes]]
        type =   "whitespace"
    command = ["foo",     "bar",  "baz", "qux",   "quux"  ]

    [[processes]]
    type = "multiline"
    command = [
        "foo",
        "bar",
        "baz"
    ]
""")


class TestParseLaunchToml(unittest.TestCase):
    """Tests the command-line functionality of parse_launch_toml.py."""

    def setUp(self):
        """Set up a temporary TOML file for each test."""
        self.temp_toml_file = tempfile.NamedTemporaryFile(
            mode="w", delete=False, suffix=".toml"
        )
        self.temp_toml_file.write(TEST_TOML_CONTENT)
        self.temp_toml_file.close()
        self.toml_path = self.temp_toml_file.name

    def tearDown(self):
        """Clean up the temporary TOML file after each test."""
        os.unlink(self.toml_path)

    def _run_script(self, args):
        """Helper method to run the script with given arguments."""
        command = ["python3", str(SCRIPT_PATH), self.toml_path] + args
        return subprocess.run(
            command,
            capture_output=True,
            text=True,
            check=True,  # Raise an exception for non-zero exit codes
        )

    def test_full_yaml_output(self):
        """Verifies the complete YAML output."""
        expected_yaml = textwrap.dedent("""\
            ---
            default_process_types:
              bash-c: cd bin/publish; ./foo --urls http://*:$PORT
              bash-c-spaces: cd 'console app/bin/publish'; ./'console app'
              simple: dotnet test foo.csproj
              simple-arg-spaces: dotnet test 'solution with spaces.sln'
              field-order: foo bar baz qux quux
              whitespace: foo bar baz qux quux
              multiline: foo bar baz""")

        result = self._run_script(["--yaml"])
        self.assertEqual(result.stdout.strip(), expected_yaml.strip())

    def test_process_extraction(self):
        """Verifies the extraction of individual process commands."""
        test_cases = {
            "bash-c": "cd bin/publish; ./foo --urls http://*:$PORT",
            "bash-c-spaces": "cd 'console app/bin/publish'; ./'console app'",
            "simple": "dotnet test foo.csproj",
            "simple-arg-spaces": "dotnet test 'solution with spaces.sln'",
            "field-order": "foo bar baz qux quux",
            "whitespace": "foo bar baz qux quux",
            "multiline": "foo bar baz",
        }

        for process_type, expected_command in test_cases.items():
            with self.subTest(process_type=process_type):
                result = self._run_script(["--process", process_type])
                self.assertEqual(result.stdout.strip(), expected_command)

    def test_nonexistent_process_fails(self):
        """Ensures the script fails when a nonexistent process is requested."""
        with self.assertRaises(subprocess.CalledProcessError):
            self._run_script(["--process", "nonexistent"])


if __name__ == "__main__":
    unittest.main()
