require "hackerrank"

module Hackerrank::Solutions::MaximizingXOR
  module Solution
    def self.evaluate(start, finish)
      max = -Float::INFINITY
      start.upto(finish) do |l|
        l.upto(finish) do |r|
          xor = l ^ r
          max = xor if xor > max
        end
      end
      max
    end
  end
end
