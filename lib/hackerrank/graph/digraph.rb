require "hackerrank/graph"
require "hackerrank/graph/directed_node"

module Hackerrank::Graph
  class Digraph < Graph
    def self.default_node_builder
      @default_node_builder ||= DirectedNode.method(:new).to_proc
    end
  end
end
