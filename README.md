# 🧮 String Calculator – Incubyte TDD Kata

## 📘 Overview

This project is a Ruby implementation of the **Incubyte String Calculator Kata**, developed using **Test Driven Development (TDD)** principles.  
The goal is to build the solution step-by-step, writing tests before implementing functionality.

---

## 🧠 Problem Statement

Create a method:

```ruby
int add(string numbers)

Requirements

| Feature                        | Example Input | Expected Output                        |
| ------------------------------ | ------------- | -------------------------------------- |
| Empty string returns `0`       | `""`          | `0`                                    |
| One number returns itself      | `"1"`         | `1`                                    |
| Two numbers return sum         | `"1,5"`       | `6`                                    |
| Handle any count of numbers    | `"1,2,3,4,5"` | `15`                                   |
| Support newlines as delimiters | `"1\n2,3"`    | `6`                                    |
| Support custom delimiters      | `"//;\n1;2"`  | `3`                                    |
| Throw on negatives (show all)  | `"1,-2,-3"`   | `"negative numbers not allowed -2,-3"` |




⚙️ Implementation

File: lib/data_summarizer.rb

class DataSummarizer
  def self.aggregate(series)
    return 0 if series.to_s.strip.empty?

    delimiter, numbers_part = extract_delimiter_and_numbers(series)
    normalized = numbers_part.tr("\n", delimiter)
    numbers = normalized.split(delimiter).map(&:to_i)

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


🧪 Testing

Framework: RSpec
All test cases are written in: spec/data_summarizer_spec.rb

Run all tests:
rspec


🧰 Setup Instructions
# Clone repository
git clone https://github.com/tejaswikatneni/string_calculator_tdd.git

# Enter folder
cd string_calculator_tdd

# Run RSpec tests
rspec


👨‍💻 Author

Tejaswi Katneni
Developed using Ruby and RSpec with a TDD-first approach.
