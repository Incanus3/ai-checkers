require 'spec_helper'
require 'ai-checkers/checkers'

describe Game do
  # this takes too much setup for a unit test
  # most of these could be mocks
  #
  # do we need a unit test for this (copy as base for integration test and
  # transform into mocks) or should we just gradually transform this into
  # integration test?
  #
  # integration test is important but how far can the integration get?
  # if the colaborators are exchangable (players, judge, board) should we
  # test all possible combinations?
  #
  # it could be very hard to simulate and excercise the whole chain from this
  # level - e.g. creating move objects and asserting board state

  # TESTING PLAYERS
  # for human player Player class is the most external in the system - the
  # outermost interface that should be integration-tested from (for now)
  #
  # for AI player, there's no outer interface - Player and Game are two equal
  # collaborating objects
  # - either the game behavior is tested by simulating the player or the player
  #   is tested by asking for moves
  #
  # - the same goes for testing the human players' UI
  #
  # => players and games can never be completely integration-tested together
  # => test the game behavior by simulating the player (use real instance or
  #    mock?)
  # => test the players (AI or UI) separately by asking for moves

  # TESTING JUDGES
  # - for testing Game behavior the judge can be either simulated or some
  #   particular Judge can be used (test depends on its behavior)
  # => for now simulate and test the Judges in isolation

  # TESTING BOARD MANIPULATION
  # - needs much setup
  # - what would integration testing of this bring?
  # - wouldn't it be just copying of unit tests into more, unimportant context?
  # - what would the integration test look like?
  #   - simulated player chooses move and is either informed about game outcome,
  #     bad move or the other player is asked for move with updated board
  #   - but validity of the move or outcome of the game is determined by the
  #     judge, which is also simulated (and tested in isolation)
  #     -> board state doesn't matter
  # => test in isolation

  # ==> make this a unit test, integration test doesn't make much sense for now
  # a) use doubles
  # - using stubs for collaborators is tedious, since we need to stub all
  #   methods that are called in the process (or fragile if null objects used)
  # b) use real instances
  # - unstubed real player's methods may have unexpected/unfeasible side effects
  # - may be slow (board)
  # c) use test fakes
  # - can be linted by same tests as all implementing classes
  # - controlled - no unwanted side-effects
  # - several predefined behaviors
  #
  # => use double for board
  # - only update! called, no variability needed -> fake is overkill, fast
  # => use fakes for players
  # - hard to stub all behavior, lints, several predefined behaviors
  # => use fake judges
  # - several predefined behaviors

  let(:white_player) { Checkers::Player.new(:white) }
  let(:black_player) { Checkers::Player.new(:black) }
  let(:players)      { { white: white_player, black: black_player } }
  let(:board)        { Checkers::Board.new }
  let(:judge)        { Checkers::Judge.new }

  subject(:game)     { Game.new(players, [:white, :black], board, judge) }

  let(:from)         { Checkers::Board::Position.new(3,1) }
  let(:to)           { Checkers::Board::Position.new(4,2) }
  let(:move)         { Checkers::Board::Move.new(from, to) }
  let(:result)       { Game::Result.new(:win, :white) }

  before do
    allow(white_player).to receive(:move) { move }
    allow(black_player).to receive(:move) { move }

    allow(judge).to receive(:valid_move?) { true }

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
