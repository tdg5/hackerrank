require "test_helper"
require "hackerrank/solutions/euler002/solution"

module Hackerrank::Test::Integration::Solutions::Euler002
  class SolutionTest < Hackerrank::Test::TestCase
    Subject = Hackerrank::Solutions::Euler002

    TEST_DATA = {
      10 => 10,
      100 => 44,
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

