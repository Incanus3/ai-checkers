Game = Struct.new(:players, :player_order, :board, :judge) do
  def run
    player_order.cycle do |current_player|
      move = players[current_player].move(board, judge)
      result = judge.result_if_over(board)
      return result if result
    end
  end
end

class Player
  def initialize(role)
    @role = role
  end

  def move(board, judge)
  end
end

Result = Struct.new(:outcome, :winner)
