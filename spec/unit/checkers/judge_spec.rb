require 'spec_helper'
require 'ai-checkers/checkers/judge'

module Checkers
  describe Judge do
    let(:judge) { Judge.new }

    include_examples 'judge lint'

    describe '#valid_moves_from' do
      it 'returns list of valid moves form given position'
    end

    describe '#valid_moves_for' do
      it 'returns list of valid moves for given color'
    end

    describe '#valid_move?' do
      it 'returns true for valid move'
      it 'returns false for invalid move'
    end
  end
end
