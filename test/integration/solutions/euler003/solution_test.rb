require "test_helper"
require "hackerrank/solutions/euler003/solution"

module Hackerrank::Test::Integration::Solutions::Euler003
  class SolutionTest < Hackerrank::Test::TestCase
    Subject = Hackerrank::Solutions::Euler003

    TEST_DATA = {
      1 => 1,
      2 => 2,
      3 => 3,
      5 => 5,
      10 => 5,
      17 => 17,
      32 => 2,
      49 => 7,
      81 => 3,
      997 => 997,
      1009 => 1009,
      2018 => 1009,
      1005973 => 1009,
      15_485_863 * 2 => 15_485_863,
      200_560_490_130 => 31,
    }.freeze

    context Subject.name do
      subject { Subject }

      context "::evaluate" do
        TEST_DATA.each do |integer, prime_factor|
          should "return #{prime_factor} for #{integer}" do
            assert_equal(prime_factor, subject.evaluate(integer))
          end
        end
      end
    end
  end
end

