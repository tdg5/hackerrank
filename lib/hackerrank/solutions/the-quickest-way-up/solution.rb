require "hackerrank/graph"

module Hackerrank::Solutions::TheQuickestWayUp
  def self.evaluate(edges)
    solution = Solution.new(edges)
    start_node, end_node = solution.graph[1], solution.graph[100]
    solution.shortest_path_length(start_node, end_node)
  end

  def self.process(input_stream = STDIN, output_stream = STDOUT)
    test_case_count = input_stream.gets.to_i
    test_case_count.times do
      edges = []
      ladder_count = input_stream.gets.to_i
      ladder_count.times do
        edges << input_stream.gets.strip.split(" ").map(&:to_i)
      end
      snake_count = input_stream.gets.to_i
      snake_count.times do
        edges << input_stream.gets.strip.split(" ").map(&:to_i)
      end
      output_stream.puts(evaluate(edges))
    end
  end

  class Solution
    attr_reader :graph

    def initialize(edges, move_range = 1..6)
      @move_range = move_range
      @graph = Hackerrank::Graph.new
      edges.each do |vx, vy|
        nx, ny = @graph[vx], @graph[vy]
        nx.link(ny)
      end
    end

    def shortest_path_length(start_node, end_node)
      hops = 0
      current_node = start_node
      while current_node != end_node
        hops += 1
        former = current_node.id
        current_node = find_optimal_move(current_node, end_node)
        puts "Moving from #{former} to #{current_node.id}" if $DEBUG
      end
      hops
    end

    def find_optimal_move(node, goal_node)
      id = node.id
      optimal_node, optimal_result = node, node.id
      @move_range.each do |move|
        candidate = @graph[id + move]
        return candidate if candidate == goal_node

        candidate = candidate.links.first if candidate.links.any?

        if candidate.id > optimal_result
          optimal_node = candidate
          optimal_result = candidate.id
        end
      end
      optimal_node
    end
  end
end
