class DataSummarizer
  def self.aggregate(series)
    return 0 if series.to_s.strip.empty?

    delimiters, numbers_part = extract_delimiter_and_numbers(series)

    # Replace all delimiters and newlines with commas
    pattern = Regexp.union(delimiters + ["\n"])
    normalized = numbers_part.gsub(pattern, ",")

    numbers = normalized.split(",").reject(&:empty?).map(&:to_i)

    negatives = numbers.select(&:negative?)
    raise "negative numbers not allowed #{negatives.join(',')}" unless negatives.empty?

    numbers.reject { |n| n > 1000 }.sum
  end

  private

  def self.extract_delimiter_and_numbers(series)
    if series.start_with?("//")
      header, body = series.split("\n", 2)

      # Handle multiple delimiters
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
