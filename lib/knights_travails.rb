class KnightPathFinder

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
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
  end

  def find_path
  end

end

p KnightPathFinder.valid_moves([4,4])
p KnightPathFinder.valid_moves([0,0])
