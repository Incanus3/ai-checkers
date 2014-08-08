require 'spec_helper'
require 'ai-checkers/checkers/judge'
require 'ai-checkers/checkers/board'

module Checkers
  describe Judge do
    let(:judge) { Judge.new }

    include_examples 'judge lint'

    describe '#valid_moves_from',:focus do
      it 'returns list of valid moves form given position' do
        board    = Board.new
        position = Board::Position.new(1,1)

        moves = judge.valid_moves_from(board, position)
      end
    end

    describe '#valid_moves_for' do
      it 'returns list of valid moves for given color'
    end

    describe '#valid_move?' do
      it 'returns true for valid move'
      it 'returns false for invalid move'
    end
  end
end
