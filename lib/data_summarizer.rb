class DataSummarizer
  def self.aggregate(series)
    return 0 if series.to_s.strip.empty?

    delimiters, numbers_part = extract_delimiter_and_numbers(series)

    # Combine all delimiters and newline into a regex pattern
    pattern = Regexp.union(delimiters + ["\n"])

    # Use scan to extract all numbers directly
    numbers = numbers_part.scan(/-?\d+/).map(&:to_i)

    negatives = numbers.select(&:negative?)
    raise "negative numbers not allowed #{negatives.join(',')}" unless negatives.empty?

    numbers.reject { |n| n > 1000 }.sum
  end

  private

  def self.extract_delimiter_and_numbers(series)
    if series.start_with?("//")
      header, body = series.split("\n", 2)

      # Handle multiple delimiters using scan
      if header.match?(/\[.*\]/)
        delimiters = header.scan(/\[(.*?)\]/).flatten
      else
        delimiters = [header[2]]
      end

      [delimiters, body]
    else
      [[","], series]
    end
  end
end
