# lib/data_summarizer.rb
class DataSummarizer
  # aggregate(series: String) -> Integer
  # Returns the sum of numbers present in the series string.
  # This is the minimal implementation for the first test.
  def self.aggregate(series)
    return 0 if series.nil? || series == ""

    # replace newline characters with commas, then split
    normalized = series.gsub("\n", ",")
    numbers = normalized.split(",").map(&:to_i)
    numbers.sum
  end
end
