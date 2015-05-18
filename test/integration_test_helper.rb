require "test_helper"

module Hackerrank::Test
  module Integration
    module Solutions
    end

    module ExpectedResultAssertion
      FIXTURE_PATH = File.expand_path("../fixtures", __FILE__).freeze

      def assert_expected_results(options = {})
        processor = options.fetch(:processor)
        input = options.fetch(:input)
        expected_output = options.fetch(:expected_output)

        output_stream = StringIO.new
        processor.process(input, output_stream)
        output_stream.rewind
        output = output_stream.read
        assert_equal expected_output, output
      end

      def fixture_path(fixture_name = nil)
        base_path = self.class.const_get(:FIXTURE_PATH)
        return base_path if !fixture_name
        File.join(base_path, fixture_name).to_s
      end

      def load_fixture(fixture_name)
        StringIO.new(File.read(fixture_path(fixture_name)))
      end
    end
  end
end
