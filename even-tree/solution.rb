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

require "hackerrank/graph"

_vertex_count, edge_count = gets.strip.split(" ").map!(&:to_i)

edges = []
edge_count.times { edges << gets.strip.split(" ").map!(&:to_i) }

graph = Hackerrank::Graph.new(&Hackerrank::Graph::Node.method(:new))

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
