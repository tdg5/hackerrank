require "integration_test_helper"
require "hackerrank/solutions/the-quickest-way-up/solution"

module Hackerrank::Test::Integration::Solutions::TheQuickestWayUp
  class SolutionIntegrationTest < Hackerrank::Test::TestCase
    Subject = Hackerrank::Solutions::TheQuickestWayUp

    subject { Subject }

    context "#{Subject.name}#evaluate" do
      context "returned result" do
        should "example 1" do
          input = <<-INPUT
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
          assert_expected_shortest_path_length(3, input)
        end

        should "example 2" do
          input = <<-INPUT
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
          assert_expected_shortest_path_length(5, input)
        end
      end

      context "test case 05" do
        context "return expected_results" do
          should "example 1" do
            input = <<-INPUT
              1
              2
              5 66
              9 88
              1
              67 8
            INPUT
            assert_expected_shortest_path_length(4, input)
          end

          should "example 2" do
            input = <<-INPUT
              1
              1
              3 90
              7
              99 10
              97 20
              98 30
              96 40
              95 50
              94 60
              93 70
            INPUT
            assert_expected_shortest_path_length(-1, input)
          end

          should "example 3" do
            input = <<-INPUT
              1
              2
              5 66
              9 88
              1
              67 8
            INPUT
            assert_expected_shortest_path_length(4, input)
          end

          should "example 4" do
            input = <<-INPUT
              1
              1
              3 90
              7
              99 10
              97 20
              98 30
              96 40
              95 50
              94 60
              93 70
            INPUT
            assert_expected_shortest_path_length(-1, input)
          end

          should "example 5" do
            input = <<-INPUT
              1
              2
              5 66
              9 88
              1
              67 8
            INPUT
            assert_expected_shortest_path_length(4, input)
          end

          should "example 6" do
            input = <<-INPUT
              1
              1
              3 90
              7
              99 10
              97 20
              98 30
              96 40
              95 50
              94 60
              93 70
            INPUT
            assert_expected_shortest_path_length(-1, input)
          end

          should "example 7" do
            input = <<-INPUT
              1
              2
              5 66
              9 88
              1
              67 8
            INPUT
            assert_expected_shortest_path_length(4, input)
          end

          should "example 8" do
            input = <<-INPUT
              1
              1
              3 90
              7
              99 10
              97 20
              98 30
              96 40
              95 50
              94 60
              93 70
            INPUT
            assert_expected_shortest_path_length(-1, input)
          end

          should "example 9" do
            input = <<-INPUT
              1
              2
              5 66
              9 88
              1
              67 8
            INPUT
            assert_expected_shortest_path_length(4, input)
          end

          should "example 10" do
            input = <<-INPUT
              1
              1
              3 90
              7
              99 10
              97 20
              98 30
              96 40
              95 50
              94 60
              93 70
            INPUT
            assert_expected_shortest_path_length(-1, input)
          end
        end
      end

      context "test case 06" do
        should "example 1" do
          input = <<-INPUT
            1
            10
            3 5
            7 8
            44 56
            36 54
            88 91
            77 83
            2 4
            9 99
            45 78
            31 75
            5
            8 6
            95 90
            96 30
            97 52
            98 86
          INPUT
          assert_expected_shortest_path_length(3, input)
        end

        should "example 2" do
          input = <<-INPUT
            1
            2
            3 54
            37 100
            1
            56 33
          INPUT
          assert_expected_shortest_path_length(3, input)
        end

        should "example 3" do
          input = <<-INPUT
            1
            1
            5 6
            1
            97 95
          INPUT
          assert_expected_shortest_path_length(17, input)
        end

        should "example 4" do
          input = <<-INPUT
            1
            10
            3 5
            7 8
            44 56
            36 54
            88 91
            77 83
            2 4
            9 99
            45 78
            31 75
            5
            8 6
            95 90
            96 30
            97 52
            98 86
          INPUT
          assert_expected_shortest_path_length(3, input)
        end

        should "example 5" do
          input = <<-INPUT
            1
            2
            3 54
            37 100
            1
            56 33
          INPUT
          begin
            $pryme = true
            assert_expected_shortest_path_length(3, input)
          ensure
            $pryme = false
          end
        end

        should "example 6" do
          input = <<-INPUT
            1
            1
            5 6
            1
            97 95
          INPUT
          assert_expected_shortest_path_length(17, input)
        end

        should "example 7" do
          input = <<-INPUT
            1
            10
            3 5
            7 8
            44 56
            36 54
            88 91
            77 83
            2 4
            9 99
            45 78
            31 75
            5
            8 6
            95 90
            96 30
            97 52
            98 86
          INPUT
          assert_expected_shortest_path_length(3, input)
        end

        should "example 8" do
          input = <<-INPUT
            1
            2
            3 54
            37 100
            1
            56 33
          INPUT
          assert_expected_shortest_path_length(3, input)
        end

        should "example 9" do
          input = <<-INPUT
            1
            1
            5 6
            1
            97 95
          INPUT
          assert_expected_shortest_path_length(17, input)
        end
      end

      def assert_expected_shortest_path_length(expected_length, input)
        input_stream = StringIO.new(input.gsub(/^ +/, ''))
        output_stream = StringIO.new
        subject.process(input_stream, output_stream)
        output_stream.rewind
        assert_equal(expected_length, output_stream.read.to_i)
      end
    end
  end
end
