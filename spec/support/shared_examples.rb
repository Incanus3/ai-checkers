shared_examples 'player lint' do
  it 'implements move' do
    expect(player).to respond_to(:move)
    expect(player.method(:move).arity).to be 2
  end

  it 'implements bad_move' do
    expect(player).to respond_to(:bad_move)
    expect(player.method(:bad_move).arity).to be 2
  end
end

shared_examples 'judge lint' do
  it 'implements valid_move?' do
    expect(judge).to respond_to(:valid_move?)
    expect(judge.method(:valid_move?).arity).to be 2
  end

  it 'implements result_if_over' do
    expect(judge).to respond_to(:result_if_over)
    expect(judge.method(:result_if_over).arity).to be 1
  end
end
