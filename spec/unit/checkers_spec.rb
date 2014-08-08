require 'spec_helper'
require 'ai-checkers/checkers'

module Checkers
  describe Judge do
    let(:judge) { Judge.new }

    include_examples 'judge lint'
  end

  describe Player do
    let(:player) { Player.new(:white) }

    include_examples 'player lint'
  end
end
