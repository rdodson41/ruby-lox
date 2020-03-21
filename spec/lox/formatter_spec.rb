# frozen_string_literal: true

require('lox/formatter')

RSpec.describe(Lox::Formatter) do
  subject :formatter do
    described_class.new(objects)
  end

  let :objects do
    Enumerator.new do |yielder|
      2.times do
        terminal << '$ '
        yielder << instance_double(Object)
      end
    end
  end

  let :terminal do
    []
  end

  describe '#each' do
    subject :each do
      formatter.each
    end

    let :strings do
      objects.map(&:inspect)
    end

    it 'yields strings' do
      expect { |block| formatter.each(&block) }
        .to(yield_successive_args(*strings))
    end

    it 'enumerates objects lazily' do
      expect { each.take(1).force }.to(change(terminal, :dup).by(['$ ']))
    end
  end
end
