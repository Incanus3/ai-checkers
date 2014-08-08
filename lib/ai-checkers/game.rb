require 'abstract_type'
require 'ai-checkers/utils/value_object'

class Game
  class Player
    include AbstractType

    def move(board, judge)
      raise NotImplementedError
    end

    def bad_move(board, move)
      raise NotImplementedError
    end
  end

  Result = Struct.new(:outcome, :winner)

  # @attr players      Hash<Symbol, Player>
  # @attr player_order [Symbol]
  include ValueObject.new(:players, :player_order, :board, :judge)

  def run
    catch :interrupt do
      player_order.cycle do |current_player|
        player = players[current_player]
        result = round(player)

        return result if result
      end
    end
  end

  private

  def round(player)
    # could take board and list of valid moves
    move = player.move(board, judge)

    if judge.valid_move?(board, move)
      board.update!(move)
      judge.result_if_over(board)
    else
      player.bad_move(board, move)
      throw :interrupt
    end
  end
end
