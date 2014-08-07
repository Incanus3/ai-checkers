require 'abstract_type'

class Game
  class Player
    include AbstractType

    abstract_method :move, :bad_move
  end

  Result = Struct.new(:outcome, :winner)

  attr_reader :players, :player_order, :board, :judge

  def initialize(players, player_order, board, judge)
    @players      = players
    @player_order = player_order
    @board        = board
    @judge        = judge
  end

  def run
    player_order.cycle do |current_player|
      player = players[current_player]
      result = round(player)

      return result if result
      return if @interrupt
    end
  end

  private

  def round(player)
    move = player.move(board, judge)

    if judge.valid_move?(board, move)
      board.update!(move)
      judge.result_if_over(board)
    else
      player.bad_move(board, move)
      @interrupt = true
    end
  end
end
