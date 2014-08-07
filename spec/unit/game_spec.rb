require 'spec_helper'
require 'ai-checkers/game'
require 'ai-checkers/checkers'

describe Game do
  let(:white_player) { Checkers::Player.new(:white) }
  let(:black_player) { Checkers::Player.new(:black) }
  let(:players)      { { white: white_player, black: black_player } }
  let(:board)        { Checkers::Board.new(8,8) }
  let(:judge)        { Checkers::Judge.new }

  subject(:game)     { Game.new(players, [:white, :black], board, judge) }

  let(:move) { double }
  let(:result) { Game::Result.new(:win, :white) }

  before do
    allow(white_player).to receive(:move) { move }
    allow(black_player).to receive(:move) { move }

    # game ends with result in second round
    first_time = true
    allow(judge).to receive(:result_if_over) do
      if first_time
        first_time = false
      else
        result
      end
    end
  end

  it 'asks the first player for its move' do
    expect(white_player).to receive(:move).with(board, judge)

    game.run
  end

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
