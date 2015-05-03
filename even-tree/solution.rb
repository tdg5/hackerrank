# Problem URL:
# https://www.hackerrank.com/challenges/even-tree
#
# Problem Statement:
# You are given a tree (a simple connected graph with no cycles). You have to
# remove as many edges from the tree as possible to obtain a forest with the
# condition that : Each connected component of the forest should contain an even
# number of vertices.
#
# To accomplish this, you will remove some edges from the tree. Find out the
# number of removed edges.
#
# Input Format:
# The first line of input contains two integers N and M. N is the number of
# vertices and M is the number of edges.  The next M lines contain two integers
# ui and vi which specifies an edge of the tree. (1-based index)
#
# Output Format:
# Print the answer, a single integer.
#
# Constraints:
# 2 <= N <= 100.
#
# Note: The tree in the input will be such that it can always be decomposed into
# components containing even number of nodes.
#
# Sample Input:
# 10 9
# 2 1
# 3 1
# 4 3
# 5 2
# 6 1
# 7 2
# 8 6
# 9 8
# 10 8
#
# Sample Output:
# 2
#
# Explanation:
# On removing edges (1, 3) and (1, 6), we can get the desired result.

require 'set'

_vertex_count, edge_count = gets.strip.split(" ").map!(&:to_i)

edges = []
edge_count.times { edges << gets.strip.split(" ").map!(&:to_i) }

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

graph = Graph.new(&Node.method(:new))
edges.each do |vx, vy|
  nx = graph[vx]
  ny = graph[vy]
  nx.value = ny.value = 0
  nx.link(ny)
end

edges_removed_count = 0
node_queue = graph.leaves
while node_queue.any?
  node = node_queue.shift
  next unless node.parent

  node_queue << node.parent if !node_queue.include?(node.parent)
  next unless node.subgraph.length % 2 == 0

  node.unlink(node.parent)
  edges_removed_count += 1
end

puts graph.inspect
