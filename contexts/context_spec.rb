

RSpec.describe '#even? method' do
  it 'returns true for even numbers' do
    expect(2.even?).to be true
    expect(4.even?).to be true
  end

  it 'returns false for odd numbers' do
    expect(1.even?).to be false
    expect(3.even?).to be false
  end

  it 'returns true for zero' do
    expect(0.even?).to be true
  end

  it 'raises an error for non-integer inputs' do
    expect { 'string'.even? }.to raise_error(NoMethodError)
    expect { [1, 2].even? }.to raise_error(NoMethodError)
  end

  # BETTER APPROACH: Nest block in another describe block
  # to avoid if and when etc. in your descriptions
  describe 'with even numbers' do
    it 'returns true' do
      expect(2.even?).to be true
    end
    it 'returns true for larger even numbers' do
      expect(100.even?).to be true
    end
    it 'returns true for negative even numbers' do
      expect(-2.even?).to be true
    end
  end

  describe 'with odd numbers' do
    it 'returns false' do
      expect(1.even?).to be false
    end
    it 'returns false for larger odd numbers' do
      expect(101.even?).to be false
    end
    it 'returns false for negative odd numbers' do
      expect(-3.even?).to be false
    end
  end

  context 'when checking zero' do # context is an alias for describe
    it 'returns true' do
      expect(0.even?).to be true
    end
  end
end
