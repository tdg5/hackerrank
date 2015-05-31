require "test_helper"
require "hackerrank/solutions/euler005/solution"

module Hackerrank::Test::Integration::Solutions::Euler005
  class SolutionTest < Hackerrank::Test::TestCase
    Subject = Hackerrank::Solutions::Euler005

    TestData = {
      3 => 6,
      10 => 2520,
    }.freeze

    context Subject.name do
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
