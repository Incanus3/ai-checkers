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

    Position = Struct.new(:row, :column) do
      def self.new!(row, column)
        new(row, column).validate
      end

      def validate
        raise ArgumentError, "row #{row} is out of bounds" unless valid_row?
        raise ArgumentError, "column #{column} is out of bounds" unless valid_column?
      end

      def valid?
        valid_row? && valid_column?
      end

      # these may return invalid positions
      # these call for polymorphysm, but what's the concept here?
      def forward(color)
        case color
        when :white
          self.class.new(row + 1, column)
        when :black
          self.class.new(row - 1, column)
        end
      end

      def left(color)
        case color
        when :white
          self.class.new(row, column - 1)
        when :black
          self.class.new(row, column + 1)
        end
      end

      def right(color)
        case color
        when :white
          self.class.new(row, column + 1)
        when :black
          self.class.new(row, column - 1)
        end
      end

      private

      def valid_row?
        0 < row && row <= RowCount
      end

      def valid_column?
        0 < column && column <= ColumnCount
      end
    end

    Piece = Struct.new(:color, :type)
    Move  = Struct.new(:from, :to)

    def initialize
      init_board
    end

    def raw_board
      @board
    end

    def update!(move)
      piece = piece_at(move.from)

      set_piece_at(move.from, nil)
      set_piece_at(move.to, piece)
    end

    def piece_at(position)
      raw_board[position.row - 1][position.column - 1]
    end

    def free?(position)
      piece_at(position).nil?
    end

    private

    def init_board
      @board = Array.new(RowCount) { Array.new(ColumnCount) }

      white_positions = [[1,1], [1,3], [1,5], [1,7],
                         [2,2], [2,4], [2,6], [2,8],
                         [3,1], [3,3], [3,5], [3,7]]
      black_positions = [[6,2], [6,4], [6,6], [6,8],
                         [7,1], [7,3], [7,5], [7,7],
                         [8,2], [8,4], [8,6], [8,8]]

      white_positions.each { |pos| set_piece_at(Position.new(*pos), Piece.new(:white, :pawn)) }
      black_positions.each { |pos| set_piece_at(Position.new(*pos), Piece.new(:black, :pawn)) }
    end

    def set_piece_at(position, piece)
      raw_board[position.row - 1][position.column - 1] = piece
    end
  end
end
