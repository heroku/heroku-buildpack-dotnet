# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Buildpack detection' do
  # This spec only tests cases where detection fails, since the success cases
  # are already tested in the specs for general buildpack functionality.

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
          remote:  !     A .NET app on Heroku must have a .NET solution ('.sln', '.slnx') or project
          remote:  !     ('.csproj', '.vbproj', '.fsproj') file in the root directory of its source code.
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
          remote:  !     
          remote:  !     Otherwise, add a .NET solution or project file to your app's root directory.
          remote:  !     
          remote:  !     For more information, see:
          remote:  !     https://devcenter.heroku.com/articles/dotnet-behavior-in-heroku#auto-detection-and-build-behavior
          remote: 
          remote: 
          remote:        More info: https://devcenter.heroku.com/articles/buildpacks#detection-failure
        OUTPUT
      end
    end
  end
end
