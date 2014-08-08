require 'spec_helper'
require 'ai-checkers/checkers/player'

module Checkers
  describe Player do
    let(:player) { Player.new(:white) }

    include_examples 'player lint'
  end
end
