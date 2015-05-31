require "hackerrank"
require "hackerrank/integer/prime_sieve"

module Hackerrank::Solutions::Euler005
  def self.process(input = STDIN, output = STDOUT)
    count = input.gets.to_i
    count.times do
      upper_bound = gets.to_i
      output.puts(evaluate(upper_bound))
    end
  end

  def self.evaluate(upper_bound)
    Solution.new(upper_bound).least_common_multiple
  end

  class Solution
    def initialize(upper_bound)
      @upper_bound = upper_bound
    end

    def least_common_multiple
      prime_factors = Hash.new(0)
      prime_factorizations.values.each do |prime_factorization|
        prime_factorization.each_pair do |prime, count|
          prime_factors[prime] = count if count > prime_factors[prime]
        end
      end
      result = 1
      prime_factors.each { |prime, count| result *= prime ** count }
      result
    end

    private

    def primes
      @primes ||= prime_generator.each_prime.take_while { |n| n <= @upper_bound }
    end

    def prime_factorizations
      return @prime_factorizations if @prime_factoriazations

      @prime_factorizations = Hash.new { |h, k| h[k] = Hash.new(0) }
      2.upto(@upper_bound) do |factor|
        working = factor
        while working > 1
          primes.each do |prime|
            while working % prime == 0
              working /= prime
              @prime_factorizations[factor][prime] += 1
            end
            break if working == 1
          end
        end
      end
      @prime_factorizations
    end

    def prime_generator
      @prime_generator ||= Hackerrank::Integer::PrimeSieve.new({
        :initial_size => sqrt,
        :maximum_size => sqrt,
      })
    end

    def sqrt
      @sqrt ||= Math.sqrt(@upper_bound)
    end
  end
end
