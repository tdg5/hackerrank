require "hackerrank"

module Hackerrank::Solutions::Euler006
  def self.evaluate(upper_bound)
    Solution.new(upper_bound).sum_difference
  end

  def self.process(input = STDIN, output = STDOUT)
    count = input.gets.to_i
    count.times do
      upper_bound = gets.to_i
      output.puts(evaluate(upper_bound))
    end
  end

  class Solution
    def initialize(upper_bound)
      @upper_bound = upper_bound
    end

    def sum_difference
      sum_squares = 0
      square_sums = 0
      1.upto(@upper_bound) do |num|
        sum_squares += num ** 2
        square_sums += num
      end
      square_sums = square_sums ** 2
      square_sums - sum_squares
    end
  end
end
