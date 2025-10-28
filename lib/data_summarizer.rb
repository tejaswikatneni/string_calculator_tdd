# lib/data_summarizer.rb
class DataSummarizer
  # aggregate(series: String) -> Integer
  # Returns the sum of numbers present in the series string.
  def self.aggregate(series)
    return 0 if series.nil? || series == ""

    delimiter = ","
    numbers_part = series

    # Handle custom delimiter syntax: //X\n
    if series.start_with?("//")
      parts = series.split("\n", 2)
      delimiter = parts[0][2]
      numbers_part = parts[1]
    end

    # Normalize newlines and split using delimiter
    normalized = numbers_part.gsub("\n", delimiter)
    numbers = normalized.split(delimiter).map(&:to_i)

    # Detect negatives
    negatives = numbers.select { |n| n < 0 }
    unless negatives.empty?
      raise "negative numbers not allowed #{negatives.join(',')}"
    end

    numbers.sum
  end
end
