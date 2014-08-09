module Checkers
  class Judge
    def valid_moves_from(board, position)
      get_targets(position).select { |t| t.valid? && board.free?(t) }
        .map { |t| Board::Move.new(position, t) }
    end

    def valid_move?(board, move)
    end

    def result_if_over(board)
    end

    private

    def get_targets(position)
      [Board::Position.new(position.row + 1, position.column - 1),
       Board::Position.new(position.row + 1, position.column + 1)]
    end
  end
end
