require 'spec_helper'
require 'ai-checkers/checkers/judge'

module Checkers
  describe Judge do
    let(:judge) { Judge.new }

    include_examples 'judge lint'
  end
end
