require "test_helper"
require "hackerrank/graph"

module Hackerrank::Test::Unit::Graph
  class GraphTest < Hackerrank::Test::TestCase
    Subject = Hackerrank::Graph::Graph

    context Subject.name do
      subject { Subject }

      context "instance" do
        subject { Subject.new }

        context "#node?" do
          should "return true if a node with the given ID exists" do
            id = :test_node
            subject[id]
            assert_equal true, subject.node?(id)
          end

          should "return false if a node with the given ID does not exist" do
            id = :test_node
            assert_equal false, subject.node?(id)
          end
        end
      end
    end
  end
end
