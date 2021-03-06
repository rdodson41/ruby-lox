# frozen_string_literal: true

require('lox')

RSpec.describe(Lox) do
  it 'has a version number' do
    expect(Lox::VERSION).not_to(be_nil)
  end
end
