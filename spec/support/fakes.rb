class FakePlayer
  def initialize(move)
    @move = move
  end

  def move(board, judge)
    @move
  end

  def bad_move(board, move)
  end
end

# game ends with result in second round
class FakeJudge
  def initialize(result)
    @result = result
    @first_time = true
  end

  def valid_move?(board, move)
    true
  end

  def result_if_over(board)
    if @first_time
      @first_time = false
    else
      @result
    end
  end
end
