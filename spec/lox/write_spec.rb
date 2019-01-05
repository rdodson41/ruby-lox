require('lox/write')

RSpec.describe(Lox::Write) do
  subject :write do
    described_class.new(objects, output)
  end

  let :objects do
    [
      instance_double(Object)
    ]
  end

  let :output do
    instance_double(IO)
  end

  describe '#call' do
    subject :call do
      write.call
    end

    before do
      allow(output).to(receive(:puts))
    end

    it 'writes the objects to the output' do
      call
      expect(output).to(have_received(:puts))
    end
  end
end
