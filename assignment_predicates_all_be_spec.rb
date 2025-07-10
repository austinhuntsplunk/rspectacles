# assignment 8: 
# Predicates, all, and be matchers 
RSpec.describe 'Predicate, all, and be Matchers' do
  it 'is question 1' do
    expect({}).to be_empty
  end

  it 'validates an array of even numbers are even' do 
    expect([10, 20, 30]).to all(be_even) 
    [10, 20, 30].each do |number|
      expect(number).to be_even
      expect(number.even?).to be true
    end
  end

  it 'validates 0, 1, 2 are >= 0' do 
    expect([0, 1, 2]).to all(be >= 0)
    [0, 1, 2].each do | number | 
      expect(number).to be >= 0
      expect(number >= 0).to be true
    end
  end

  it 'validates truthy and falsy values' do
    # "hello"
    # false
    # 0
    # -10
    # []
    # 99.99
    # :hello
    # true
    # nil
    # [1, 2, 3]
    expect("hello").to be_truthy
    expect(false).to be_falsy
    expect(0).to be_truthy # In Ruby, 0 is truthy
    expect(-10).to be_truthy
    expect([]).to be_truthy
    expect(99.99).to be_truthy
    expect(:hello).to be_truthy
    expect(true).to be_truthy
    expect(nil).to be_falsy 
    expect(nil).to be_nil 
    expect([1,2,3]).to be_truthy
    expect([1,2,3]).to all(be_truthy)
  end
end
