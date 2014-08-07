require 'spec_helper'
require 'ai-checkers/checkers/board'

module Checkers
  describe Board do
    it 'new board has pieces on initial positions' do
      board = Board.new

      white_piece = board.piece_at(Board::Position.new(1, 1))

      expect(white_piece.color).to be :white
      expect(white_piece.type).to be :pawn

      black_piece = board.piece_at(Board::Position.new(8,8))

      expect(black_piece.color).to be :black
      expect(black_piece.type).to be :pawn
    end
  end
end
