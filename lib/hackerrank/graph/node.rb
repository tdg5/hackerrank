require "set"

module Hackerrank::Graph
  class Node
    attr_accessor :value
    attr_reader :id

    def initialize(id)
      @id = id
      @links = Set.new
    end

    def ancestors
      @ancestors ||= @links.select { |node| node.id < id }
    end

    def children
      @children ||= @links.select { |node| node.id > id }
    end

    def descendents
      @descendents ||= children + children.flat_map(&:descendents)
    end

    def degree
      @links.length
    end

    def grand_children
      @grand_children ||= children.flat_map(&:children)
    end

    def inspect
      queue = [
        [ self, [] ],
      ]
      results = Set.new
      while queue.any?
        node, paths = queue.shift
        paths = paths.dup.push(node.id)

        if node.children.none?
          results << paths
          next
        end

        node.children.each do |child|
          queue << [ child, paths ]
        end
      end
      results
    end

    def link(*nodes)
      nodes.flatten.each do |node|
        register_link(node)
        node.register_link(self)
      end
      reset_cache
      self
    end

    def links
      @links.dup
    end

    def parent
      @parent ||= begin
        min = Float::INFINITY
        min_node = nil
        @links.each do |node|
          diff = id - node.id
          if diff < 1 || diff > min
            next
          elsif diff == 1
            min_node = node
            break
          end
          min, min_node = diff, node
        end
        min_node
      end
    end

    def subgraph
      [self].concat(descendents)
    end

    def unlink(*nodes)
      nodes.flatten.each do |node|
        unregister_link(node)
        node.unregister_link(self)
      end
      reset_cache
      self
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
      @ancestors =
      @children =
      @descendents =
      @parent =
      @grand_children = nil
    end
  end
end
