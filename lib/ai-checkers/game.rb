Game = Struct.new(:players, :player_order, :board, :judge) do
  def run
    player_order.cycle do |current_player|
      player = players[current_player]
      result = round(player)

      return result if result
      return if @interrupt
    end
  end

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

class Player
  def initialize(role)
    @role = role
  end

  def move(board, judge)
  end

  def bad_move(board, move)
  end
end

Result = Struct.new(:outcome, :winner)
