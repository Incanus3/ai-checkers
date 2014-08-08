require_relative 'game'
require_relative 'checkers/board'

module Checkers
  class Judge
    def valid_move?(board, move)
    end

    def result_if_over(board)
    end
  end

  class Player < Game::Player
    def initialize(color)
      @role = color
    end

    def bad_move(board, move)
    end
  end
end
