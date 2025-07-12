

RSpec.describe 'Contain Exactly Matcher' do
  it 'checks if an array contains exactly the specified elements' do
    expect([1, 2, 3]).to contain_exactly(1, 2, 3)
    expect([1, 2, 3]).to contain_exactly(3, 2, 1)
    expect([1, 2, 3]).not_to contain_exactly(1, 2)
    expect([1, 2, 3]).to contain_exactly(1, 2, 3.0) # NOTE: that 3 and 3.0 are considered the same by contain_exactly
    expect([]).to contain_exactly # empty array matches empty expectation
    expect(%i[a b]).to contain_exactly(:b, :a) # order does not matter
  end
end
