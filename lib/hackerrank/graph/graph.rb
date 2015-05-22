module Hackerrank::Graph
  class Graph
    def initialize
      @nodes = {}
      @default_proc = Proc.new if block_given?
    end

    def [](id)
      node = @nodes[id]
      return node if node
      return if @default_proc.nil?
      @nodes[id] = @default_proc.call(id)
    end

    def leaves
      nodes.delete_if { |node| node.links.count != 1 }
    end

    def node?(id)
      @nodes.key?(id)
    end

    def nodes
      @nodes.values
    end

    def roots
      nodes.select { |node| !node.parent }
    end

    def inspect
      roots.map(&:inspect).join("\n")
    end
  end
end
