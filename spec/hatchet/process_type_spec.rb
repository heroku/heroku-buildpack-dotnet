# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Process types' do
  context 'when using solution with spaces in file names, and verbosity level configured' do
    let(:app) do
      Hatchet::Runner.new(
        'spec/fixtures/solution_with_spaces',
        config: { 'MSBUILD_VERBOSITY_LEVEL' => 'normal' }
      )
    end

    it 'runs the expected test command in CI' do
      app.run_ci do |test_run|
        expect(clean_output(test_run.output)).to include(<<~OUTPUT)
          Running test command: `dotnet test "solution with spaces.sln" --verbosity normal`
        OUTPUT
      end
    end

    it 'runs the published default process type' do
      app.deploy do |app|
        expect(clean_output(app.output)).to include(<<~OUTPUT)
          -----> Process types
                 Detecting process types from published artifacts
                 Found `console-app`: bash -c cd 'console app/bin/publish'; ./'console app'
                 No Procfile detected
                 Registering detected process types as launch processes
                 WARNING: Auto-detected process type names were recently changed.
                 
                 The buildpack now lowercases the process name and replaces spaces, dots (`.`),
                 and underscores (`_`) with hyphens (`-`). Currently scaled worker dynos may be
                 removed following deployment if the process type name was changed as a result.
                 
                 Verify that all expected worker dynos are running on your app with `heroku ps`,
                 and scale up recently renamed processes as needed using the detected process
                 type names listed above.
                 
                 For more information on automatic process type detection, see:
                 https://devcenter.heroku.com/articles/dotnet-behavior-in-heroku#automatic-process-type-detection
        OUTPUT
        expect(clean_output(app.output)).to include(<<~OUTPUT)
          Default types for buildpack -> console-app
        OUTPUT

        expect(`heroku run -a #{app.name} console-app`).to match('Hello, World!')
      end
    end
  end
end
