require 'spec_helper'
require 'ai-checkers/checkers/judge'
require 'ai-checkers/checkers/board'

module Checkers
  describe Judge do
    let(:judge) { Judge.new }
    let(:board) { Board.new }

    include_examples 'judge lint'

    describe '#valid_moves_from' do
      context 'for white pawn' do
        let(:center_position)   { Board::Position.new(3,3) }
        let(:left_position)     { Board::Position.new(3,1) }

        let(:left_target)       { Board::Position.new(4,2) }
        let(:right_target)      { Board::Position.new(4,4) }

        let(:piece)             { Board::Piece.new(:white, :pawn) }

        context 'when both target positions are valid' do
          it 'returns forward-left and forward-right moves' do
            moves = judge.valid_moves_from(board, center_position)

            expect(moves).to match_array [Board::Move.new(center_position, left_target),
                                          Board::Move.new(center_position, right_target)]
          end
        end # context 'when both target positions are valid'

        context 'when one of the positions is out of bounds' do
          it "doesn't include it" do
            moves = judge.valid_moves_from(board, left_position)

            expect(moves).to match_array [Board::Move.new(left_position, left_target)]
          end
        end

        context 'when one of the positions is engaged' do
          before do
            board.send(:set_piece_at, right_target, piece)
          end

          it "doesn't include it" do
            moves = judge.valid_moves_from(board, center_position)

            expect(moves).to match_array [Board::Move.new(center_position, left_target)]
          end
        end
      end # context 'for white pawn'

      context 'for black pawn' do
        let(:position)     { Board::Position.new(6,2) }

        let(:left_target)  { Board::Position.new(5,1) }
        let(:right_target) { Board::Position.new(5,3) }

        let(:piece)        { Board::Piece.new(:black, :pawn) }

        context 'when both target positions are valid' do
          it 'returns forward-left and forward-right moves' do
            moves = judge.valid_moves_from(board, position)

            expect(moves).to match_array [Board::Move.new(position, left_target),
                                          Board::Move.new(position, right_target)]
          end
        end # context 'when both target positions are valid'
      end # context 'for black pawn'
    end # describe '#valid_moves_from'

    describe '#valid_moves_for' do
      it 'returns list of valid moves for given color'
    end

    describe '#valid_move?' do
      let(:position)    { Board::Position.new(3,3) }
      let(:good_target) { Board::Position.new(4,2) }
      let(:bad_target)  { Board::Position.new(5,1) }

      it 'returns true for valid move' do
        expect(judge.valid_move?(board, Board::Move.new(position, good_target))).to be true
      end

      it 'returns false for invalid move' do
        expect(judge.valid_move?(board, Board::Move.new(position, bad_target))).to be false
      end
    end
  end
end
