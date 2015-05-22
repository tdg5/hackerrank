require "securerandom"

module Hackerrank::Graph
  class Graph
    attr_reader :name

    def initialize(opts = nil)
      options = opts.nil? ? default_options : default_options.merge!(opts)
      @name = options[:name]
      @nodes = {}
      @default_proc = Proc.new if block_given?
    end

    def [](id)
      node = @nodes[id]
      return node if node
      return if @default_proc.nil?
      @nodes[id] = @default_proc.call(id)
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

    private

    def default_options
      {
        :name => generate_name,
      }
    end
  end
end
