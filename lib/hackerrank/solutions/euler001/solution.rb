require "hackerrank"

module Hackerrank::Solutions::Euler001
  def self.process(input = STDIN, output = STDOUT)
    count = input.gets.to_i
    count.times do
      upper_bound = gets.to_i
      output.puts(evaluate(upper_bound))
    end
  end

  def self.evaluate(upper_bound)
    Solution.new(upper_bound).sum
  end

  class Solution
    def initialize(upper_bound)
      @upper_bound = upper_bound - 1
    end

    def binomial(limit)
      limit * (limit + 1) / 2
    end

    def sum
      sum = binomial(@upper_bound / 3) * 3
      sum += binomial(@upper_bound / 5) * 5
      sum -= binomial(@upper_bound / 15) * 15
      sum
    end
  end
end
