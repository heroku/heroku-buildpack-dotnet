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
          remote:        Detected .NET file to publish: `/tmp/build_.*/foo.csproj`
          remote:        Inferring version requirement from `/tmp/build_.*/foo.csproj`
          remote:        Detected version requirement: .*
          remote:        Resolved .NET SDK version .*
          remote: -----> SDK installation
          remote:        Downloading SDK from .*
          remote:        Verifying SDK checksum
          remote:        Installing SDK
          remote: -----> Publish solution
          remote:        Using `Release` build configuration
          remote:        Running `dotnet publish /tmp/build_.*/foo.csproj --runtime linux-x64 "-p:PublishDir=bin/publish"`
          remote: 
          remote:            Determining projects to restore...
          remote:            Restored /tmp/build_.*/foo.csproj .*
          remote:            foo -> /tmp/build_.*/bin/Release/net8.0/linux-x64/foo.dll
          remote:            foo -> /tmp/build_.*/bin/publish/
          remote: 
          remote:        Done .*
          remote: -----> Setting launch table
          remote:        Detecting process types from published artifacts
          remote:        Added `foo`: .*
          remote: -----> Done .*
          remote: -----> Discovering process types
          remote:        Procfile declares types     -> \\(none\\)
          remote:        Default types for buildpack -> foo
        REGEX
      end
    end
  end
end
