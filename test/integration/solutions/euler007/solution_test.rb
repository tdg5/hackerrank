require "test_helper"
require "hackerrank/solutions/euler007/solution"

module Hackerrank::Test::Integration::Solutions::Euler007
  class SolutionTest < Hackerrank::Test::TestCase
    Subject = Hackerrank::Solutions::Euler007

    TestData = {
      3 => 5,
      6 => 13,
      10_001 => 104743,
      100_001 => 1299721,
      1_000_001 => 15485867,
    }.freeze

    context Subject.name do
      subject { Subject }

      context "#evaluate" do
        TestData.each do |input, output|
          should "return #{output} for #{input}" do
            assert_equal output, Subject.evaluate(input)
          end
        end
      end
    end
  end
end

