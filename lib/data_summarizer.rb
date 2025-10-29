class DataSummarizer
  def self.aggregate(series)
    return 0 if series.to_s.strip.empty?

    # Extract all numbers (positive or negative)
    numbers = series.scan(/-?\d+/).map(&:to_i)

    # Handle negatives
    if (negatives = numbers.filter(&:negative?)).any?
	  raise "negative numbers not allowed #{negatives.join(',')}"
	end
	
    # Ignore numbers > 1000 and return sum
    numbers.reject { |n| n > 1000 }.sum
  end
end