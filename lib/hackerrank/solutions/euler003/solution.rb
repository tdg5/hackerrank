require "hackerrank"
require "hackerrank/integer/prime_sieve"

module Hackerrank::Solutions::Euler003
  def self.process(input = STDIN, output = STDOUT)
    count = input.gets.to_i
    count.times { output.puts(evaluate(gets.to_i)) }
  end

  def self.evaluate(integer)
    Solution.new(integer).largest_prime_factor
  end

  class Solution
    def initialize(value)
      @value = value
    end

    def largest_prime_factor
      largest_prime = 1
      sqrt = Math.sqrt(@value)
      working = @value
      prime_generator.each_prime do |prime|
        if working % prime == 0
          largest_prime = prime
          working /= prime while working > 1 && working % prime == 0
          break if working == 1
          sqrt = Math.sqrt(working)
        elsif prime >= sqrt
          largest_prime = working
          break
        end
      end
      largest_prime == 1 ? @value : largest_prime
    end

    private

    def prime_generator
      size = Math.sqrt(@value)
      @prime_generator ||= Hackerrank::Integer::PrimeSieve.new({
        :initial_size => size,
        :maximum_size => size,
      })
    end
  end
end
