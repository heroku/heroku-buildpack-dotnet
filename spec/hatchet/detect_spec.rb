# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Buildpack detection' do
  context 'when there are no recognized .NET files' do
    let(:app) { Hatchet::Runner.new('spec/fixtures/no_dotnet_files', allow_failure: true) }

    it 'fails detection' do
      app.deploy do |app|
        expect(clean_output(app.output)).to include(<<~OUTPUT)
          remote: -----> App not compatible with buildpack: #{DEFAULT_BUILDPACK_URL}
          remote:        
          remote:  !     Error: No .NET solution or project files (such as `foo.sln` or `foo.csproj`) found.
          remote:  !     
          remote:  !     For more information, see:
          remote:  !     https://devcenter.heroku.com/articles/dotnet-behavior-in-heroku#auto-detection
          remote: 
          remote: 
          remote:        More info: https://devcenter.heroku.com/articles/buildpacks#detection-failure
        OUTPUT
      end
    end
  end

  context 'when project.toml has no solution_file configuration' do
    let(:app) { Hatchet::Runner.new('spec/fixtures/project_toml_msbuild_only', allow_failure: true) }

    it 'fails detection' do
      app.deploy do |app|
        expect(clean_output(app.output)).to include('App not compatible with buildpack')
        # Ensure fallback error handling works even if Python TOML parsing fails
        expect(clean_output(app.output)).to include(
          'Error: No .NET solution or project files (such as `foo.sln` or `foo.csproj`) found.'
        )
      end
    end
  end

  context 'when project.toml has solution_file configuration' do
    let(:app) { Hatchet::Runner.new('spec/fixtures/project_toml_solution_only', allow_failure: true) }

    it 'passes detection with configured solution_file' do
      app.deploy do |app|
        # Detection should pass because solution_file is configured in project.toml
        # Build will fail because the configured solution file doesn't exist
        expect(clean_output(app.output)).to include('remote: -----> .NET app detected')
        expect(clean_output(app.output)).to include('Using configured solution file: `MyApp.sln`')
      end
    end
  end
end
