require 'spec_helper'
require 'ai-checkers/checkers/board'

module Checkers
  describe Board do
    subject(:board) { Board.new }

    it 'new board has pieces on initial positions' do
      expect(board.piece_at(Board::Position.new(1,1)))
        .to eq Board::Piece.new(:white, :pawn)

      expect(board.piece_at(Board::Position.new(8,8)))
        .to eq Board::Piece.new(:black, :pawn)
    end

    describe '#update!' do
      it 'moves the piece' do
        from = Board::Position.new(3,1)
        to   = Board::Position.new(4,2)
        move = Board::Move.new(from, to)

        board.update!(move)

        expect(board.piece_at(from)).to be nil
        expect(board.piece_at(to)).to eq Board::Piece.new(:white, :pawn)
      end
    end
  end
end
