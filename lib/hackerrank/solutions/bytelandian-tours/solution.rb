require "hackerrank"
require "hackerrank/graph"
require "hackerrank/graph/node_extensions/circuitous_trails"

module Hackerrank::Solutions::BytelandianTours
  class Node < Hackerrank::Graph::Node
    include Hackerrank::Graph::NodeExtensions::CircuitousTrails
  end

  def self.evaluate(edges, name = nil)
    Solution.new(edges, name).circuitous_trail_count
  end

  def self.process(input_stream = STDIN, output_stream = STDOUT)
    test_case_count = input_stream.gets.to_i
    test_case_count.times do
      number_of_cities = input_stream.gets.to_i
      edge_count = number_of_cities - 1
      edges = edge_count.times.map { input_stream.gets.strip.split(" ").map(&:to_i) }
      output_stream.puts(evaluate(edges))
    end
  end

  class Solution
    attr_reader :graph

    def initialize(edges, name = nil)
      @graph = Hackerrank::Graph.new(:name => name, &Node.method(:new).to_proc)
      edges.each do |vx, vy|
        nx = @graph[vx]
        ny = @graph[vy]
        nx.value = ny.value = 0
        nx.link(ny)
      end
      add_new_edges
    end

    def add_new_edges
      edges_to_add = {}
      @graph.nodes.each do |node|
        links_to_ignore = node.links + [node]
        cousins = node.links.map(&:links).inject(&:+) - links_to_ignore
        older_cousins = cousins.select { |cousin| cousin.id > node.id }
        next if older_cousins.none?
        edges_to_add[node] = older_cousins
      end
      edges_to_add.each_pair { |node, cousins| node.link(cousins) }
    end

    def circuitous_trail_count
      expected_circuit_length = @graph.nodes.length + 1
      circuits = @graph.roots.first.circuitous_trails.select do |circuit|
        circuit.length == expected_circuit_length
      end
      circuits.length
    end
  end
end
