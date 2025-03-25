# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Buildpack execution' do
  context 'when building a valid .NET app' do
    let(:app) { Hatchet::Runner.new('spec/fixtures/basic_web_8.0') }

    it 'successfully compiles' do
      app.deploy do |app|
        expect(clean_output(app.output)).to match(Regexp.new(<<~REGEX))
          remote: -----> Using buildpack: #{DEFAULT_BUILDPACK_URL}
          remote: -----> .NET app detected
          remote: -----> SDK version detection
          remote:        Detected .NET project: `/tmp/build_.*/foo.csproj`
          remote:        Inferring version requirement from `/tmp/build_.*/foo.csproj`
          remote:        Detected version requirement: .*
          remote:        Resolved .NET SDK version .*
          remote: -----> SDK installation
          remote:        Downloading SDK from .*
          remote:        Verifying SDK checksum
          remote:        Installing SDK
          remote: -----> Publish app
          remote:        Running `dotnet publish /tmp/build_.*/foo.csproj --runtime linux-x64 "-p:PublishDir=bin/publish" --artifacts-path /tmp/build_artifacts`
          remote: 
          remote:            Determining projects to restore...
          remote:            Restored /tmp/build_.*/foo.csproj .*
          remote:            foo -> /tmp/build_artifacts/bin/foo/release_linux-x64/foo.dll
          remote:            foo -> /tmp/build_.*/bin/publish/
          remote: 
          remote:        Done .*
          remote: -----> Process types
          remote:        Detecting process types from published artifacts
          remote:        Found `web`: .*
          remote:        No Procfile detected
          remote:        Registering detected process types as launch processes
          remote: -----> Done .*
          remote: -----> Discovering process types
          remote:        Procfile declares types     -> \\(none\\)
          remote:        Default types for buildpack -> web
        REGEX
      end
    end
  end

  context 'when building an app with MSBUILD_VERBOSITY_LEVEL=invalid' do
    let(:app) do
      Hatchet::Runner.new(
        'spec/fixtures/basic_web_8.0',
        config: { 'MSBUILD_VERBOSITY_LEVEL' => 'invalid' },
        allow_failure: true
      )
    end

    it 'fails with error from CNB' do
      app.deploy do |app|
        expect(clean_output(app.output)).to include(<<~OUTPUT)
          remote:  !     Invalid MSBuild verbosity level
          remote:  !    
          remote:  !     The `MSBUILD_VERBOSITY_LEVEL` environment variable value (`invalid`)
          remote:  !     is invalid. Did you mean one of the following supported values?
          remote:  !    
          remote:  !     d
          remote:  !     detailed
          remote:  !     diag
          remote:  !     diagnostic
          remote:  !     m
          remote:  !     minimal
          remote:  !     n
          remote:  !     normal
          remote:  !     q
          remote:  !     quiet
        OUTPUT
      end
    end
  end
end
