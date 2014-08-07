require 'spec_helper'
require 'ai-checkers/checkers/board_presenter'

module Checkers
  class Board
    describe Presenter do
      describe '#to_s' do
        it 'returns textual representation of board' do
          representation = <<END
-----------------
| |x| |x| |x| |x|
-----------------
|x| |x| |x| |x| |
-----------------
| |x| |x| |x| |x|
-----------------
| | | | | | | | |
-----------------
| | | | | | | | |
-----------------
|o| |o| |o| |o| |
-----------------
| |o| |o| |o| |o|
-----------------
|o| |o| |o| |o| |
-----------------
END

          expect(Presenter.new(Board.new).to_s)
            .to eq representation
        end
      end
    end
  end
end
