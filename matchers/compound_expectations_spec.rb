

# Compound expectations allow us to combine more than one matcher on a single line
# and are useful for testing multiple conditions at once.

RSpec.describe 'Compound Expectations' do
  describe 25 do
    it 'is an odd perfect square with satisfy' do
      expect(subject).to(satisfy { |n| n.odd? && (Math.sqrt(n) % 1).zero? })
    end
    it 'is an odd perfect square with and' do
      expect(subject).to be_odd.and(satisfy { |n| (Math.sqrt(n) % 1).zero? })
    end

    it 'is greater than 20 and less than 30 with satisfy' do
      expect(subject).to(satisfy { |n| n > 20 && n < 30 })
    end

    it 'is greater than 20 and less than 30 with and' do
      expect(subject).to (be > 20).and(be < 30)
    end

    it 'is a multiple of 5 and not a multiple of 3' do
      expect(subject).to(satisfy { |n| (n % 5).zero? && n % 3 != 0 })
    end

    it { is_expected.to be_odd.and(satisfy { |n| (Math.sqrt(n) % 1).zero? }) }
  end

  describe 'Caterpillar' do
    it 'starts with Cat and ends with pillar' do
      expect('Caterpillar').to start_with('Cat').and end_with('pillar')
    end
    it { is_expected.to start_with('Cat').and end_with('pillar') }
  end

  describe [:usa, :canada, :mexico] do
    it 'can check for multiple possibilities' do
      expect(subject.sample).to eq(:usa).or eq(:canada).or eq(:mexico)
    end
  end

  describe 'firetruck' do
    it 'starts with fire and ends with truck' do
      expect(subject).to start_with('fire').and end_with('truck')
    end
  end

  describe 20 do
    it 'is even and responds to times method' do
      expect(subject).to be_even.and respond_to(:times)
    end
  end

  describe [4, 8, 15, 16, 23, 42] do
    it 'includes 42 and starts with 4,8,15' do
      expect(subject).to include(42).and start_with(4, 8, 15)
    end
  end
end
