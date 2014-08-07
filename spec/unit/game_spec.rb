require 'spec_helper'
require 'ai-checkers/game'
require 'ai-checkers/checkers'

describe Game do
  let(:white_player) { Player.new(:white) }
  let(:black_player) { Player.new(:black) }
  let(:players)      { { white: white_player, black: black_player } }
  let(:board)        { Checkers::Board.new(8,8) }
  let(:judge)        { Checkers::Judge.new }

  subject(:game)     { Game.new(players, [:white, :black], board, judge) }

  it 'can be run and returns result' do
    result = game.run

    expect(result.outcome).to be :win
    expect(result.winner).to be :white
  end

  it 'asks the first player for its move' do
    expect(white_player).to receive(:move).with(board, judge)

    game.run
  end
end
