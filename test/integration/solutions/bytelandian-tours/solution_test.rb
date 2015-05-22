require "integration_test_helper"
require "hackerrank/solutions/bytelandian-tours/solution"

module Hackerrank::Test::Integration::Solutions::BytelandianTours
  class SolutionIntegrationTest < Hackerrank::Test::TestCase
    Subject = Hackerrank::Solutions::BytelandianTours

    subject { Subject }

    context "#{Subject.name}#evaluate" do
      context "return expected result" do
        should "example 1" do
          assert_circuitous_trail_count(2, [
            [0, 1],
            [1, 2],
          ])
        end

        should "example 2" do
          assert_circuitous_trail_count(4, [
            [0, 1],
            [1, 2],
            [2, 3],
            [2, 4]
          ])
        end

        should "example 3" do
          assert_circuitous_trail_count(0, [
            [0, 3],
            [1, 6],
            [2, 6],
            [2, 9],
            [3, 8],
            [3, 5],
            [4, 7],
            [5, 7],
            [5, 6],
          ])
        end

        should "example 4" do
          assert_circuitous_trail_count(2, [
            [0, 7],
            [0, 9],
            [1, 5],
            [1, 2],
            [2, 7],
            [3, 8],
            [3, 6],
            [4, 9],
            [6, 9],
          ])
        end

        should "example 5" do
          assert_circuitous_trail_count(0, [
            [0, 3],
            [0, 6],
            [1, 5],
            [1, 8],
            [2, 4],
            [2, 6],
            [6, 7],
            [7, 9],
            [8, 9],
          ])
        end

        should "example 6" do
          assert_circuitous_trail_count(4, [
            [0, 4],
            [0, 2],
            [1, 2],
            [2, 8],
            [2, 9],
            [3, 6],
            [3, 7],
            [5, 7],
            [5, 9],
          ])
        end

        should "example 7" do
          assert_circuitous_trail_count(2, [
            [0, 2],
            [1, 6],
            [1, 2],
            [2, 9],
            [3, 7],
            [3, 6],
            [4, 8],
            [5, 9],
            [7, 8],
          ])
        end

        should "example 8" do
          assert_circuitous_trail_count(2, [
            [0, 9],
            [1, 3],
            [1, 9],
            [2, 3],
            [4, 5],
            [4, 8],
            [4, 9],
            [6, 7],
            [7, 8],
          ])
        end

        should "example 9" do
          assert_circuitous_trail_count(2, [
            [0, 4],
            [0, 1],
            [0, 6],
            [1, 8],
            [2, 5],
            [3, 5],
            [3, 6],
            [3, 9],
            [6, 7],
          ])
        end

        should "example 10" do
          assert_circuitous_trail_count(2, [
            [0, 2],
            [0, 6],
            [1, 6],
            [1, 5],
            [2, 3],
            [4, 5],
            [4, 7],
            [5, 8],
            [7, 9],
          ])
        end

        should "example 11" do
          assert_circuitous_trail_count(4, [
            [0, 6],
            [1, 5],
            [2, 6],
            [3, 8],
            [3, 7],
            [4, 7],
            [4, 5],
            [5, 9],
            [6, 9],
          ])
        end

        should "example 12" do
          assert_circuitous_trail_count(0, [
            [0, 3],
            [0, 9],
            [1, 2],
            [2, 5],
            [3, 4],
            [4, 5],
            [4, 7],
            [4, 8],
            [6, 7],
          ])
        end
      end

      should "example 13" do
        assert_circuitous_trail_count(0, [
          [0, 7],
          [1, 3],
          [1, 9],
          [2, 8],
          [3, 4],
          [4, 8],
          [5, 6],
          [6, 8],
          [7, 8],
        ])
      end

      should "example 14" do
        assert_circuitous_trail_count(0, [
          [0, 5],
          [0, 6],
          [1, 4],
          [2, 4],
          [2, 8],
          [2, 9],
          [3, 9],
          [6, 8],
          [7, 9],
        ])
      end

      should "example 15" do
        assert_circuitous_trail_count(4, [
          [0, 5],
          [0, 4],
          [1, 6],
          [2, 6],
          [3, 4],
          [4, 8],
          [5, 7],
          [6, 9],
          [8, 9],
        ])
      end

      should "example 16" do
        assert_circuitous_trail_count(8, [
          [0, 7],
          [1, 3],
          [1, 7],
          [2, 4],
          [2, 7],
          [2, 8],
          [2, 6],
          [5, 7],
          [6, 9],
        ])
      end

      should "example 17" do
        assert_circuitous_trail_count(2, [
          [0, 3],
          [0, 6],
          [1, 2],
          [1, 6],
          [1, 5],
          [4, 7],
          [4, 9],
          [5, 9],
          [8, 9],
        ])
      end

      should "example 18" do
        assert_circuitous_trail_count(8, [
          [0, 2],
          [0, 9],
          [1, 3],
          [1, 7],
          [1, 8],
          [1, 5],
          [4, 7],
          [5, 9],
          [6, 7],
        ])
      end

      should "example 19" do
        assert_circuitous_trail_count(12, [
          [0, 9],
          [1, 7],
          [2, 7],
          [3, 7],
          [3, 6],
          [4, 6],
          [5, 6],
          [5, 9],
          [7, 8],
        ])
      end

      should "example 20" do
        assert_circuitous_trail_count(0, [
          [0, 6],
          [1, 7],
          [1, 2],
          [2, 9],
          [3, 5],
          [3, 9],
          [4, 6],
          [4, 8],
          [8, 9],
        ])
      end

      should "example 21" do
        assert_circuitous_trail_count(0, [
          [0, 3],
          [0, 5],
          [0, 9],
          [1, 3],
          [2, 9],
          [4, 8],
          [5, 7],
          [6, 8],
          [8, 9],
        ])
      end

      should "example 22" do
        assert_circuitous_trail_count(0, [
          [0, 6],
          [1, 6],
          [1, 8],
          [1, 5],
          [2, 3],
          [3, 8],
          [4, 5],
          [5, 9],
          [6, 7],
        ])
      end
    end

    private
    def assert_circuitous_trail_count(count, edges)
      assert_equal(count, subject.evaluate(edges, test_name))
    end

    def test_name
      "#{self.class.name}-#{name}"
    end
  end

  class TestCase4 < Hackerrank::Test::TestCase
    include Hackerrank::Test::Integration::ExpectedResultAssertion
    Subject = Hackerrank::Solutions::BytelandianTours

    context "test case 4" do
      should "output expected results" do
        assert_expected_results({
          :processor => Subject,
          :input => load_fixture("input04.txt"),
          :expected_output => load_fixture("output04.txt"),
        })
      end
    end

    def fixture_path(fixture_name = nil)
      return super unless fixture_name
      full_name = File.join("solutions/bytelandian-tours", fixture_name).to_s
      super(full_name)
    end
  end
end
