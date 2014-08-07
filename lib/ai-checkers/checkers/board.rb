#  v column 1
# -----------------
# | |x| |x| |x| |x| - row 8
# -----------------
# |x| |x| |x| |x| |
# -----------------
# | |x| |x| |x| |x|
# -----------------
# | | | | | | | | |
# -----------------
# | | | | | | | | |
# -----------------
# |o| |o| |o| |o| |
# -----------------
# | |o| |o| |o| |o|
# -----------------
# |o| |o| |o| |o| | - row 1
# -----------------
#       column 8 ^
#
# o - white pawn
# O - white king
# x - black pawn
# X - black king
#
module Checkers
  class Board
    RowCount = ColumnCount = 8
    Position = Struct.new(:row, :column)
    Piece    = Struct.new(:color, :type)
    Move     = Struct.new(:from, :to)

    def initialize
      init_board
    end

    def update!(move)
      piece = piece_at(move.from)

      set_piece_at(move.from, nil)
      set_piece_at(move.to, piece)
    end

    def piece_at(position)
      @board[position.row - 1][position.column - 1]
    end

    private

    def init_board
      @board = Array.new(RowCount) { Array.new(ColumnCount) }

      white_positions = [[1,1], [1,3], [1,5], [1,7],
                         [2,2], [2,4], [2,6], [2,8],
                         [3,1], [3,3], [3,5], [3,7]]
      black_positions = [[6,2], [6,4], [6,6], [6,8],
                         [7,1], [7,3], [7,5], [7,7],
                         [8,2], [8,4], [8,6], [8,8],]

      white_positions.each { |pos| set_piece_at(Position.new(*pos), Piece.new(:white, :pawn)) }
      black_positions.each { |pos| set_piece_at(Position.new(*pos), Piece.new(:black, :pawn)) }
    end

    def set_piece_at(position, piece)
      @board[position.row - 1][position.column - 1] = piece
    end
  end
end
