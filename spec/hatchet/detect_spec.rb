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
          remote:  !     Error: Your app is configured to use the .NET buildpack,
          remote:  !     but we couldn't find a supported .NET project or solution file.
          remote:  !     
          remote:  !     A .NET app on Heroku must have either:
          remote:  !     - A .NET solution ('.sln') or project ('.csproj', '.vbproj', '.fsproj')
          remote:  !       file in the root directory of its source code.
          remote:  !     - A 'SOLUTION_FILE' environment variable that specifies the path to the
          remote:  !       solution file.
          remote:  !     - A 'project.toml' file that specifies the path to the solution file,
          remote:  !       for example:
          remote:  !     
          remote:  !         [com.heroku.buildpacks.dotnet]
          remote:  !         solution_file = "path/to/your/app.sln"
          remote:  !     
          remote:  !     Currently the root directory of your app contains:
          remote:  !     
          remote:  !     .gitkeep
          remote:  !     
          remote:  !     If your app already has a solution or project file, check that it:
          remote:  !     
          remote:  !     1. Is in the top-level directory (not a subdirectory).
          remote:  !     2. Isn't listed in '.gitignore' or '.slugignore'.
          remote:  !     3. Has been added to the Git repository and committed.
          remote:  !     4. If using 'project.toml', check that the 'solution_file' path is
          remote:  !        correct, points to an existing file, and that the filename's
          remote:  !        casing matches exactly.
          remote:  !     
          remote:  !     Otherwise, add a .NET solution or project file to your app's root directory,
          remote:  !     or configure the path to it in 'project.toml'.
          remote:  !     
          remote:  !     For more information, see:
          remote:  !     https://devcenter.heroku.com/articles/dotnet-behavior-in-heroku
        OUTPUT
      end
    end
  end

  context 'when there are no recognized .NET files but SOLUTION_FILE is set' do
    let(:app) { Hatchet::Runner.new('spec/fixtures/no_dotnet_files', config: { SOLUTION_FILE: 'MyApp.sln' }, allow_failure: true) }

    it 'passes detection with configured solution_file' do
      app.deploy do |app|
        # Detection should pass because SOLUTION_FILE is set
        # Build will fail because the configured solution file doesn't exist
        expect(clean_output(app.output)).to include('remote: -----> .NET app detected')
        expect(clean_output(app.output)).to include('Using configured solution file: `MyApp.sln`')
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
          'Error: Your app is configured to use the .NET buildpack'
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
