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

    def circuitous_trails
      queue = [
        {
          :node => self,
          :path => [],
          :traversed => Set.new,
        },
      ]
      circuits = Set.new
      while queue.any?
        path_data = queue.shift
        node, path, traversed = path_data.values_at(:node, :path, :traversed)

        path << node
        traversed << node

        candidates = node.links - traversed

        puts [
          "node: #{node.id}",
          "path: #{path.map(&:id).inspect}",
          "links: #{node.links.map(&:id)}",
          "traversed: #{traversed.map(&:id).inspect}",
        ].join(" ") if $DEBUG

        if candidates.none? && node.links.include?(self)
          circuits << path.push(self)
          next
        end

        candidates.each do |candidate|
          queue << {
            :node => candidate,
            :path => path.dup,
            :traversed => traversed.dup,
          }
        end
      end
      circuits
    end

    def degree
      @links.length
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
          results.push(paths)
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
        reset_cache
      end
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
      @children = @descendents = @parent = @ancestors = nil
    end
  end
end
