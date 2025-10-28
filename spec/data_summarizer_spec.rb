# spec/data_summarizer_spec.rb
require_relative '../lib/data_summarizer'

RSpec.describe DataSummarizer do
  describe '.aggregate' do
    context 'when the input is empty' do
      it 'returns 0 for an empty string' do
        expect(DataSummarizer.aggregate("")).to eq(0)
      end
    end

    context 'when input has a single numeric value' do
	  it 'returns that numeric value as integer' do
	    expect(DataSummarizer.aggregate("7")).to eq(7)
	  end
	end

	context 'when input has two comma-separated numbers' do
	  it 'returns the sum of both numbers' do
	    expect(DataSummarizer.aggregate("1,5")).to eq(6)
	  end
	end

	context 'when input has multiple comma-separated numbers' do
	  it 'returns the total sum of all numbers' do
	    expect(DataSummarizer.aggregate("1,2,3,4,5")).to eq(15)
	  end
	end

	context 'when input includes newline characters as delimiters' do
	  it 'treats newline as a valid separator along with commas' do
	    expect(DataSummarizer.aggregate("1\n2,3")).to eq(6)
	  end
	end

	context 'when input defines a custom delimiter' do
	  it 'uses the custom delimiter to split numbers' do
	    expect(DataSummarizer.aggregate("//;\n1;2")).to eq(3)
	  end

	  it 'works with different delimiters' do
	    expect(DataSummarizer.aggregate("//#\n2#3#4")).to eq(9)
	  end
	end

	context 'when input contains negative numbers' do
	  it 'raises an exception mentioning the negative number' do
	    expect {
	      DataSummarizer.aggregate("1,-2,3")
	    }.to raise_error("negative numbers not allowed -2")
	  end

	  it 'includes all negative numbers in the exception message' do
	    expect {
	      DataSummarizer.aggregate("1,-2,-5,3")
	    }.to raise_error("negative numbers not allowed -2,-5")
	  end
	end

	context 'edge cases' do
	  it 'returns 0 for input with only newline characters' do
	    expect(DataSummarizer.aggregate("\n")).to eq(0)
	  end

	  it 'ignores extra spaces around numbers' do
	    expect(DataSummarizer.aggregate(" 1 , 2 , 3 ")).to eq(6)
	  end

	  it 'handles custom delimiter but empty body gracefully' do
	    expect(DataSummarizer.aggregate("//;\n")).to eq(0)
	  end
	end
  end
end
