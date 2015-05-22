module Hackerrank::Graph::NodeExtensions
  module CircuitousTrails
    def circuitous_trails(length = nil)
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
          if length.nil? || path.length == length - 1
            circuits << path.push(self)
          end
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
  end
end
