require 'spec_helper'

describe FakePlayer do
  let(:player) { FakePlayer.new(nil) }

  include_examples 'player lint'
end

describe FakeJudge do
  let(:judge) { FakeJudge.new(nil) }

  include_examples 'judge lint'
end
