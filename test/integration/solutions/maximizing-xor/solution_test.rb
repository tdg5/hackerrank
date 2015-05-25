require "test_helper"
require "hackerrank/solutions/maximizing-xor/solution"

module Hackerrank::Test::Integration::Solutions::MaximizingXOR
  class SolutionTest < Hackerrank::Test::TestCase
    Subject = Hackerrank::Solutions::MaximizingXOR::Solution

    TEST_DATA = {
      1..10 => 15,
      10..15 => 7,
      1..65 => 127,
    }.freeze

    context Subject.name do
      subject { Subject }

      context "::evaluate" do
        TEST_DATA.each do |range, max_xor|
          should "return #{max_xor} for #{range.inspect}" do
            assert_equal(max_xor, subject.evaluate(range.min, range.max))
          end
        end
      end
    end
  end
end
