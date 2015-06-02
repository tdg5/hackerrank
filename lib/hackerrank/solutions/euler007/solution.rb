require "hackerrank"
require "hackerrank/integer/prime_sieve"

module Hackerrank::Solutions::Euler007
  def self.process(input = STDIN, output = STDOUT)
    count = input.gets.to_i
    count.times do
      n = gets.to_i
      output.puts(evaluate(n))
    end
  end

  def self.evaluate(n)
    Solution.new.nth_prime(n)
  end

  class Solution
    def nth_prime(n)
      count = 0
      prime_generator.each_prime { |prime| return prime if (count += 1) == n }
    end

    def prime_generator
      @prime_generator ||= Hackerrank::Integer::PrimeSieve.new({
        :initial_size => 1_024,
        :maximum_size => 8_388_608,
      })
    end
  end
end
