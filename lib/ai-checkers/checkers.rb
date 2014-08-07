require_relative 'game'
require_relative 'checkers/board'

module Checkers
  class Judge
    def valid_move?(board, move)
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
