module Checkers
  class Board
    def initialize(row_count, col_count)
      @row_count    = row_count
      @column_count = col_count
    end

    def update!(move)
    end
  end

  class Judge
    def valid_move?(board, move)
      true
    end

    def result_if_over(board)
      # Result.new(:win, :white)
    end
  end

  class Player < Game::Player
    def initialize(role)
      @role = role
    end

    def bad_move(board, move)
    end
  end
end
