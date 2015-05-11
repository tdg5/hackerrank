require 'set'

module Hackerrank::Graph
  class Node
    attr_accessor :value
    attr_reader :id, :links

    def initialize(id)
      @id = id
      @links = Set.new
    end

    def children
      @children ||= @links.select { |node| node.id > id }
    end

    def descendents
      @descendents ||= children.dup.concat(children.flat_map(&:descendents))
    end

    def inspect
      me = "#{id.to_s}:#{subgraph.length}"
      me.concat(" =>") if children.any?
      [me].concat(children.map { |node| node.inspect.map { |desc| "  #{desc}" } }.flatten)
    end

    def link(node)
      register_link(node)
      node.register_link(self)
      reset_cache
    end

    def parent
      @parent ||= links.detect { |node| node.id < id }
    end

    def subgraph
      [self].concat(descendents)
    end

    def unlink(node)
      unregister_link(node)
      node.unregister_link(self)
      reset_cache
    end

    protected
    def register_link(node)
      @links << node
    end

    def unregister_link(node)
      @links.delete(node)
    end

    private
    def reset_cache
      @children = @descendents = @parent = nil
    end
  end
end
