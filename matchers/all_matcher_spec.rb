

RSpec.describe 'All Matchers' do
  it 'allows for aggregate checks' do
    [1, 2, 3].each do |number|
      expect(number).to be_positive
      expect(number).to be < 4
      expect(number).to be_a(Integer)
    end

    # better way to write the above using aggregate checks
    expect([1, 2, 3]).to all(be_between(1, 3))
    expect([1, 2, 3]).to all(be_a(Integer))

    expect([2, 4, 6]).to all(be_even)
    expect([1, 3, 5]).to all(be_odd)
    expect([[], [], []]).to all(be_empty)
    expect([0, 0, 0, 0]).to all(be_zero)
    expect([1, 2, 3, 4, 5, 6]).to all(be < 10)
  end

  describe [5, 7, 9] do
    it { is_expected.to all(be_odd) }
    it { is_expected.to all(be > 4) }
    it { is_expected.to all(be < 10) }
    it { is_expected.to all(be_a(Integer)) }
    it { is_expected.to all(be_between(5, 9)) }
  end
end
