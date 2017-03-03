require_relative "00_tree_node"

class KnightPathFinder
  attr_reader :root

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    @root = PolyTreeNode.new(@start_pos)
    build_move_tree
  end

  def self.valid_moves(pos)
    x, y = pos
    pos_moves = [
      [x - 2, y - 1],
      [x - 1, y + 1],
      [x - 1, y + 2],
      [x + 1, y + 2],
      [x + 2, y + 1],
      [x + 2, y - 1],
      [x + 1, y - 2],
      [x - 1, y - 2]
    ]

    valid_moves = pos_moves.select do |move|
      (0..7).include?(move.first) && (0..7).include?(move.last)
    end

    valid_moves
  end

  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos)
    new_moves = valid_moves.reject do |move|
      @visited_positions.include?(move)
    end

    new_moves.each do |move|
      @visited_positions << move
    end

    new_moves
  end

  def build_move_tree
    # root = PolyTreeNode.new(@start_pos)
    queue = [root]

    until queue.empty?
      current_node = queue.shift
      moves = self.new_move_positions(current_node.value)

      moves.each do |pos|
        child_node = PolyTreeNode.new(pos)
        child_node.parent = current_node
        queue << child_node
      end
    end
  end

  def find_path(end_pos)
    final_node = root.dfs(end_pos)
    [@start_pos] + trace_path_back(final_node)
  end

  def trace_path_back(final_node)
    current_node = final_node
    tracer = []
    until current_node == root
      tracer.unshift(current_node.value)
      current_node = current_node.parent
    end
    tracer
  end
end

k = KnightPathFinder.new([0,0])
p k.find_path([7,6])
p k.find_path([6,2])
