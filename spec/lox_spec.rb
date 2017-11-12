RSpec.describe Lox do
  describe '::VERSION' do
    it 'is not nil' do
      expect(Lox::VERSION).not_to be_nil
    end
  end
end
