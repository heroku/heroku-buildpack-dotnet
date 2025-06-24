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
          remote: -----> Process types
          remote:        Detecting process types from published artifacts
          remote:        Found `console-app`: bash -c cd 'console app/bin/publish'; ./'console app'
          remote:        No Procfile detected
          remote:        Registering detected process types as launch processes
        OUTPUT
        expect(clean_output(app.output)).to include(<<~OUTPUT)
          Default types for buildpack -> console-app
        OUTPUT

        expect(`heroku run -a #{app.name} console-app`).to match('Hello, World!')
      end
    end
  end
end
