class DataSummarizer
  def self.aggregate(series)
    return 0 if series.to_s.strip.empty?

    delimiter, numbers_part = extract_delimiter_and_numbers(series)

    # Normalize newlines correctly using gsub (for multi-char delimiters)
    normalized = numbers_part.gsub("\n", delimiter)

    numbers = normalized.split(delimiter).map(&:to_i)

    negatives = numbers.select(&:negative?)
    raise "negative numbers not allowed #{negatives.join(',')}" unless negatives.empty?

    # Ignore numbers greater than 1000
    numbers.reject { |n| n > 1000 }.sum
  end

  private

  def self.extract_delimiter_and_numbers(series)
    if series.start_with?("//")
      header, body = series.split("\n", 2)

      # Handle multi-character delimiters like //[***]
      if header.match?(/\[.*\]/)
        delimiter = header.scan(/\[(.*?)\]/).flatten.first
      else
        delimiter = header[2]
      end

      [delimiter, body]
    else
      [",", series]
    end
  end
end
