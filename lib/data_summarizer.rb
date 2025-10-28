# lib/data_summarizer.rb
class DataSummarizer
  # aggregate(series: String) -> Integer
  # Returns the sum of numbers present in the series string.
  def self.aggregate(series)
    return 0 if series.to_s.strip.empty?

    delimiter, numbers_part = extract_delimiter_and_numbers(series)

    # Normalize delimiters
    normalized = numbers_part.tr("\n", delimiter)
    numbers = normalized.split(delimiter).map(&:to_i)

    # Handle negatives
    negatives = numbers.select(&:negative?)
    raise "negative numbers not allowed #{negatives.join(',')}" unless negatives.empty?

    numbers.sum
  end

  private

  def self.extract_delimiter_and_numbers(series)
    if series.start_with?("//")
      header, body = series.split("\n", 2)
      [header[2], body]
    else
      [",", series]
    end
  end
end
