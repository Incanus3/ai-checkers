require 'spec_helper'
require 'ai-checkers/game'

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

describe Game do
  let(:move)         { double('move') }
  let(:board)        { double('board', update!: nil) }
  let(:result)       { double('result') }

  let(:judge)        { FakeJudge.new(result) }
  let(:white_player) { FakePlayer.new(move) }
  let(:black_player) { FakePlayer.new(move) }
  let(:players)      { { white: white_player, black: black_player } }

  subject(:game)     { Game.new(players, [:white, :black], board, judge) }

  it 'asks the first player for its move' do
    expect(white_player).to receive(:move).with(board, judge)

    game.run
  end

  # TODO: test reaction to bad move
  # - notification of players
  # - skip of board update, loop interrupt, error result
  # - or asking player for new move
  # - player can signal interruption
  it 'validates move returned by player' do
    expect(judge).to receive(:valid_move?).with(board, move)

    game.run
  end

  it 'updates board by move returned by player' do
    expect(board).to receive(:update!).with(move).twice

    game.run
  end

  it 'asks the next player for its move' do
    expect(black_player).to receive(:move).with(board, judge)

    game.run
  end

  it 'returns result when over' do
    game_result = game.run

    expect(game_result).to be result
  end
end
