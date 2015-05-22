require "securerandom"

module Hackerrank::Graph
  class Graph
    attr_reader :default_proc, :name

    def self.default_node_builder
      @default_node_builder ||= Hackerrank::Graph::Node.method(:new).to_proc
    end

    def initialize(opts = nil)
      options = opts.nil? ? default_options : default_options.merge!(opts)
      @name = options[:name]
      @nodes = {}
      @default_proc = block_given? ? Proc.new : self.class.default_node_builder
    end

    def [](id)
      node = @nodes[id]
      return node if node
      return if @default_proc.nil?
      @nodes[id] = @default_proc.call(id)
    end

    def dup
      opts = {
        :name => @name,
      }
      newb = self.class.new(opts, &@default_proc)
      nodes.each do |node|
        new_node = newb[node.id]
        node.links.each { |link| new_node.link(newb[link.id]) }
      end
      newb
    end

    def generate_name
      SecureRandom.uuid
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

    def size
      @nodes.length
    end

    private

    def default_options
      {
        :name => generate_name,
      }
    end
  end
end
