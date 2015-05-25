require "test_helper"
require "hackerrank/solutions/euler001/solution"

module Hackerrank::Test::Integration::Solutions::Euler001
  class SolutionTest < Hackerrank::Test::TestCase
    Subject = Hackerrank::Solutions::Euler001

    TEST_DATA = {
      10 => 23,
      100 => 2318,
    }.freeze

    context Subject.name do
      subject { Subject }

      context "::evaluate" do
        TEST_DATA.each do |upper_bound, sum|
          should "return #{sum} for #{upper_bound}" do
            assert_equal(sum, subject.evaluate(upper_bound))
          end
        end
      end
    end
  end
end
