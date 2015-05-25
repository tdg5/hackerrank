require "hackerrank"

module Hackerrank::Solutions::Euler002
  def self.process(input = STDIN, output = STDOUT)
    count = input.gets.to_i
    count.times do
      limit = gets.to_i
      output.puts(evaluate(limit))
    end
  end

  def self.evaluate(limit)
    Solution.new(limit).sum
  end

  class Solution
    def initialize(limit)
      @limit = limit
      @term_cache = { 1 => 1, 2 => 2, 3 => 3, 4 => 5 }
      @max_cached_term = 4
    end

    def term(index)
      @term_cache[index] ||= begin
        (@max_cached_term + 1).upto(index) do |i|
          @term_cache[i] = @term_cache[i - 2] + @term_cache[i - 1]
        end
        @max_cached_term = index
        @term_cache[index]
      end
    end

    def even_terms_under_limit
      i = 1
      while (next_term = term(i)) < @limit
        i += 1
        yield next_term if next_term.even?
      end
      nil
    end

    def sum
      to_enum(:even_terms_under_limit).reduce(0, :+)
    end
  end
end
