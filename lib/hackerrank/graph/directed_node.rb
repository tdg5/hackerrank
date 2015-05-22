module Hackerrank::Graph
  class DirectedNode < Node
    def link(*nodes)
      nodes.flatten.each { |node| register_link(node) }
      reset_cache
      self
    end

    def unlink(*nodes)
      nodes.flatten.each { |node| unregister_link(node) }
      reset_cache
      self
    end
  end
end
