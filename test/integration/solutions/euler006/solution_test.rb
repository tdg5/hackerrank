require "test_helper"
require "hackerrank/solutions/euler006/solution"

module Hackerrank::Test::Integration::Solutions::Euler006
  class SolutionTest < Hackerrank::Test::TestCase
    Subject = Hackerrank::Solutions::Euler006

    TestData = {
      3 => 22,
      10 => 2640,
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
