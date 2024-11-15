# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Buildpack detection' do
  # This spec only tests cases where detection fails, since the success cases
  # are already tested in the specs for general buildpack functionality.

  context 'when a valid .NET app is detected' do
    let(:app) { Hatchet::Runner.new('spec/fixtures/basic_web_8.0') }

    it 'returns foo' do
      app.deploy do |app|
        expect(clean_output(app.output)).to include(<<~OUTPUT)
          remote: -----> Foo: #{DEFAULT_BUILDPACK_URL}
        OUTPUT
      end
    end
  end
end
