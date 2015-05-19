require "integration_test_helper"
require "hackerrank"
require "hackerrank/solutions/the-quickest-way-up/solution"

module Hackerrank::Test::Integration::Solutions::TheQuickestWayUp
  class SolutionIntegrationTest < Hackerrank::Test::TestCase
    Subject = Hackerrank::Solutions::TheQuickestWayUp

    subject { Subject }

    context "#{Subject.name}#evaluate" do
      context "returned result" do
        should "example 1" do
          input_stream = StringIO.new(<<-INPUT.gsub(/^ +/, ''))
            1
            3
            32 62
            42 68
            12 98
            7
            95 13
            97 25
            93 37
            79 27
            75 19
            49 47
            67 17
          INPUT
          assert_expected_shortest_path_length(3, input_stream)
        end

        should "example 2" do
          input_stream = StringIO.new(<<-INPUT.gsub(/^ +/, ''))
            1
            4
            8 52
            6 80
            26 42
            2 72
            9
            51 19
            39 11
            37 29
            81 3
            59 5
            79 23
            53 7
            43 33
            77 21
          INPUT
          assert_expected_shortest_path_length(5, input_stream)
        end
      end

      def assert_expected_shortest_path_length(expected_length, input_stream)
        output_stream = StringIO.new
        subject.process(input_stream, output_stream)
        output_stream.rewind
        assert_equal(expected_length, output_stream.read.to_i)
      end
    end
  end
end
