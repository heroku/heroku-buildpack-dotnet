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
end
