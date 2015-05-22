require "test_helper"
require "hackerrank/graph"

module Hackerrank::Test::Unit::Graph
  class GraphTest < Hackerrank::Test::TestCase
    Subject = Hackerrank::Graph::Graph

    context Subject.name do
      subject { Subject }

      context "instance" do
        subject { Subject.new(@opts) }

        context "#dup" do
          should "create a replica of the receiver" do
            node_count = rand(29) + 1
            0.upto(node_count, &subject.method(:[]))

            (rand(10) + 1).times do
              nodes = subject.nodes
              first_node = nodes[rand(nodes.size)]
              nodes.delete(first_node)
              (rand(5) + 1).times do
                second_node = nodes[rand(nodes.size)]
                nodes.delete(second_node)
                first_node.link(second_node)
              end
            end

            clone = subject.dup
            assert_equal subject.default_proc, clone.default_proc
            assert_equal subject.name, clone.name
            assert_equal subject.size, clone.size
            subject.nodes.each do |node|
              id = node.id
              assert_equal true, clone.node?(id)
              assert_equal subject[id].value, clone[id].value
              refute_equal subject[id].object_id, clone[id].object_id
              original_links = subject[id].links.map(&:id).sort
              assert_equal original_links, clone[id].links.map(&:id).sort
            end
          end
        end

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

          should "use default_node_builder by default if no proc given" do
            id = SecureRandom.uuid
            default_builder = Subject.default_node_builder
            Subject.expects(:default_node_builder).returns(default_builder)
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
            count = rand(29) + 1
            count.times { |i| subject[i] }
            assert_equal count, subject.size
          end
        end
      end
    end
  end
end
