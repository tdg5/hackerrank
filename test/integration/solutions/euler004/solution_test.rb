require "test_helper"
require "hackerrank/solutions/euler004/solution"

module Hackerrank::Test::Integration::Solutions::Euler004
  class SolutionTest < Hackerrank::Test::TestCase
    Subject = Hackerrank::Solutions::Euler004
    TestData = {
      101110 => 101101,
      800000 => 793397,
      100000000 => 99000099,
    }.freeze

    context Subject.name do
      subject { Subject }

      context "#evaluate" do
        TestData.each do |integer, result|
          should "return a result of #{result} for #{integer}" do
            assert_equal result, subject.evaluate(integer)
          end
        end
      end
    end
  end
end
