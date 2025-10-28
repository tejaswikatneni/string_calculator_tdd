# spec/data_summarizer_spec.rb
require_relative '../lib/data_summarizer'

RSpec.describe DataSummarizer do
  describe '.aggregate' do
    context 'when the input is empty' do
      it 'returns 0 for an empty string' do
        expect(DataSummarizer.aggregate("")).to eq(0)
      end
    end
  end
end
