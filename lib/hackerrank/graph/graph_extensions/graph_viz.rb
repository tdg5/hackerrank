require "graphviz"

module Hackerrank::Graph::GraphExtensions::GraphViz
  def visualize!
    gviz = GraphViz.new(:G, :type => :graph )
    links = Set.new
    gviz_nodes = {}
    nodes.each do |node|
      gviz_nodes[node.id] = gviz.add_node(node.id.to_s)
      node.links.each do |link|
        links << [node, link].sort_by(&:id)
      end
    end
    links.each do |node1, node2|
      gviz.add_edges(gviz_nodes[node1.id], gviz_nodes[node2.id])
    end
    gviz.output(:svg => "graphs/#{@name}.svg")
  end
end
