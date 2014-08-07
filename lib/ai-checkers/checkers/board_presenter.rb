require_relative 'board'

module Checkers
  class Board
    class Presenter < SimpleDelegator
      PieceMapping = {
        nil                      => ' ',
        Piece.new(:white, :pawn) => 'o',
        Piece.new(:white, :king) => 'O',
        Piece.new(:black, :pawn) => 'x',
        Piece.new(:black, :king) => 'X'
      }

      def to_s
        output = row_separator

        raw_board.reverse.each do |row|
          output << row_representation(row)
          output << row_separator
        end

        output
      end

      private

      def row_separator
        "-----------------\n"
      end

      def column_separator
        '|'
      end

      def row_representation(row)
        output = column_separator

        row.each do |piece|
          output << piece_representation(piece)
          output << column_separator
        end

        output << "\n"

        output
      end

      def piece_representation(piece)
        PieceMapping[piece]
      end
    end
  end
end
