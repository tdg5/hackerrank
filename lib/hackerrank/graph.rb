module Hackerrank
  module Graph
    module GraphExtensions
    end

    module NodeExtensions
    end

    def self.new(*args, &block)
      Graph.new(*args, &block)
    end
  end
end

require "hackerrank/graph/graph"
require "hackerrank/graph/node"
