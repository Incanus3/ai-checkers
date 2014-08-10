module Checkers
  class Judge
    def valid_moves_from(board, position)
      get_targets(board, position).select { |t| t.valid? && board.free?(t) }
        .map { |t| Board::Move.new(position, t) }
    end

    def valid_move?(board, move)
      valid_moves_from(board, move.from).include? Board::Move.new(move.from, move.to)
    end

    def result_if_over(board)
    end

    private

    def get_targets(board, position)
      # if position referenced board, this could be position.piece.color (LoD)
      color = board.piece_at(position).color

      [position.forward(color).left(color), position.forward(color).right(color)]
    end
  end
end
