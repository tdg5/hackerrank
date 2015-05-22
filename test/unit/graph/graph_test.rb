require "test_helper"
require "hackerrank/graph"

module Hackerrank::Test::Unit::Graph
  class GraphTest < Hackerrank::Test::TestCase
    Subject = Hackerrank::Graph::Graph

    context Subject.name do
      subject { Subject }

      context "instance" do
        subject { Subject.new(@opts) }

        context "#initialize" do
          should "take a name for the graph" do
            name = :test_graph
            @opts = {
              :name => name,
            }
            subject
            assert_equal name, subject.name
          end

          should "take a proc for creating nodes" do
            yielded = false
            instance = Subject.new do |key|
              yielded = true
              Hackerrank::Graph::Node.new(key)
            end
            instance[:test_node]
            assert_equal true, yielded
          end

          should "use Node.new by default if no proc given" do
            id = SecureRandom.uuid
            node = Hackerrank::Graph::Node.new(id)
            Hackerrank::Graph::Node.expects(:new).with(id).returns(node)
            assert_equal id, subject[id].id
          end
        end

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

        context "#size" do
          should "return the node count of the graph" do
            assert_equal 0, subject.size
            count = rand(29)
            count.times { |i| subject[i] }
            assert_equal count, subject.size
          end
        end
      end
    end
  end
end
