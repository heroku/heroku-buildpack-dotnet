# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Heroku CI' do
  context 'when using solution with a test project' do
    let(:app) { Hatchet::Runner.new('spec/fixtures/netslnwithtests') }

    it 'installs SDK and runs tests' do
      app.run_ci do |test_run|
        expect(clean_output(test_run.output)).to match(Regexp.new(<<~REGEX, Regexp::MULTILINE))
          -----> .NET app detected
          -----> SDK version detection
                 Detected .NET solution: `/app/netslnwithtests.sln`
                 Detecting version requirement from root global.json file
                 Detected version requirement: `=9.0.201`
                 Resolved .NET SDK version `9.0.201` \\(linux-amd64\\)
          -----> SDK installation
                 Downloading SDK from https://download.visualstudio.microsoft.com/download/pr/82a7fc96-b53b-4af4-ac3a-ef0a6c9325d5/84e522c31482538cddf696d03c5b20af/dotnet-sdk-9.0.201-linux-x64.tar.gz .*
                 Verifying SDK checksum
                 Installing SDK
          -----> Done .*
          -----> No test-setup command provided. Skipping.
          -----> Running .NET buildpack tests...
                 Running test command: `dotnet test netslnwithtests.sln`
                   Determining projects to restore...
                   Restored /app/xunittests/xunittests.csproj .*
                   xunittests -> /app/xunittests/bin/Debug/net9.0/xunittests.dll
                 Test run for /app/xunittests/bin/Debug/net9.0/xunittests.dll \\(.NETCoreApp,Version=v9.0\\)
                 VSTest version 17.13.0 \\(x64\\)
                 
                 Starting test execution, please wait...
                 A total of 1 test files matched the specified pattern.
                 
                 Passed!  - Failed:     0, Passed:     1, Skipped:     0, Total:     1, Duration: .* - xunittests.dll \\(net9.0\\)
          -----> .NET buildpack tests completed successfully
        REGEX
      end
    end
  end

  context 'when using solution with filename spaces, and verbosity level configured' do
    let(:app) do
      Hatchet::Runner.new(
        'spec/fixtures/solution_with_spaces',
        config: { 'MSBUILD_VERBOSITY_LEVEL' => 'normal' }
      )
    end

    it 'runs expected test command' do
      app.run_ci do |test_run|
        expect(clean_output(test_run.output)).to include(<<~OUTPUT)
          Running test command: `dotnet test "solution with spaces.sln" --verbosity normal`
        OUTPUT
      end
    end

    it 'runs published application' do
      app.deploy do |app|
        expect(clean_output(app.output)).to include(<<~OUTPUT)
          Found `consoleapp`: bash -c cd 'console app/bin/publish'; ./'console app'
        OUTPUT
        expect(clean_output(app.output)).to include(<<~OUTPUT)
          Default types for buildpack -> consoleapp
        OUTPUT

        expect(`heroku run -a #{app.name} consoleapp`).to match('Hello, World!')
      end
    end
  end
end
