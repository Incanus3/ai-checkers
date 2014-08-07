module Checkers
  class Board
    def initialize(row_count, col_count)
      @row_count    = row_count
      @column_count = col_count
    end
  end

  class Judge
    def result_if_over(board)
      Result.new(:win, :white)
    end
  end
end
