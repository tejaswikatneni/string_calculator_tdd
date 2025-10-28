# lib/data_summarizer.rb
class DataSummarizer
  # aggregate(series: String) -> Integer
  # Returns the sum of numbers present in the series string.
  # This is the minimal implementation for the first test.
  def self.aggregate(series)
    return 0 if series.nil? || series == ""

    delimiter = ","
    numbers_part = series

    # Detect custom delimiter pattern: //X\n
    if series.start_with?("//")
      parts = series.split("\n", 2)
      delimiter = parts[0][2]         # get character after //
      numbers_part = parts[1]
    end

    # Replace newline characters with the current delimiter
    normalized = numbers_part.gsub("\n", delimiter)
    numbers = normalized.split(delimiter).map(&:to_i)

    numbers.sum
  end
end
