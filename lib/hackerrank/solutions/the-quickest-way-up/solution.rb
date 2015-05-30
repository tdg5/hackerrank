require "hackerrank"
require "hackerrank/graph/digraph"

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

    DEFAULT_INITIALIZE_OPTIONS = {
      :graph_size => 100,
      :move_range => 1..6,
      :starting_position => 1,
    }.freeze

    def initialize(edges, options = {})
      opts = DEFAULT_INITIALIZE_OPTIONS.merge(options)
      @move_range = opts[:move_range]
      @graph_size = opts[:graph_size]
      @starting_position = opts[:starting_position]

      @graph = Hackerrank::Graph::Digraph.new
      edges.each do |vx, vy|
        nx, ny = @graph[vx], @graph[vy]
        nx.link(ny)
      end
    end

    def shortest_path_length(start_node, end_node)
      length = cost_graph[@graph_size].value
      length.integer? ? length : -1
    end

    def cost_graph
      costs = @graph.dup

      costs[@starting_position].value = 0
      (@starting_position + 1).upto(@graph_size) do |idx|
        costs[idx].value = Float::INFINITY
      end

      start_idx = @starting_position
      while start_idx
        working_start_idx = start_idx
        start_idx = nil
        working_start_idx.upto(@graph_size) do |idx|
          next if costs[idx].links.any?
          candidate_value = costs[idx].value + 1
          @move_range.each do |offset|
            break if idx + offset > @graph_size
            neighbor = costs[idx + offset]
            if neighbor.children.any?
              neighbor = neighbor.children.first
            elsif neighbor.parent
              neighbor = neighbor.parent
              should_rewind = true
            end
            next if neighbor.value <= candidate_value

            neighbor.value = candidate_value
            if should_rewind && (start_idx.nil? || neighbor.id < start_idx)
              start_idx = neighbor.id
            end
          end
        end
      end
      costs
    end
  end
end
