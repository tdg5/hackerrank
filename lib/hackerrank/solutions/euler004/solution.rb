require "hackerrank"

module Hackerrank::Solutions::Euler004
  def self.process(input = STDIN, output = STDOUT)
    count = input.gets.to_i
    count.times do
      upper_bound = gets.to_i
      output.puts(evaluate(upper_bound))
    end
  end

  def self.evaluate(upper_bound)
    Solution.new(upper_bound).largest_palindrome
  end

  class Solution
    def initialize(upper_bound)
      @upper_bound = upper_bound
    end

    def digits
      @digits ||= Math.log10(Math.sqrt(@upper_bound)).ceil
    end

    def largest_palindrome
      largest_palindrome = 0
      digits_lower_bound = 10 ** (digits - 1)
      digits_upper_bound = [
        @upper_bound / digits_lower_bound,
        10 ** digits - 1,
      ].min
      digits_upper_bound.downto(digits_lower_bound) do |x|
        break if x * digits_upper_bound <= largest_palindrome

        digits_upper_bound.downto(x) do |y|
          product = x * y
          if product < @upper_bound && product > largest_palindrome && palindrome?(product)
            largest_palindrome = product
          end
        end
      end
      largest_palindrome
    end

    # Inefficient, but it works.
    def palindrome?(integer)
      integer.to_s == integer.to_s.reverse
    end
  end
end
