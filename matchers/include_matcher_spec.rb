

RSpec.describe 'include matcher' do
  describe 'hot chocolate' do
    it 'checks for substring inclusion' do
      expect('hot chocolate').to include('hot')
      expect('hot chocolate').to include('chocolate')
      expect('hot chocolate').not_to include('coffee')
      expect('hot chocolate').to include('hot', 'chocolate')
    end

    it { is_expected.to include('hot', 'chocolate') }
  end

  describe [10, 20, 30] do
    it 'checks for inclusion in the array, regardless of order' do
      expect(subject).to include(10, 20, 30)
      expect(subject).to include(20, 10, 30)
      expect(subject).not_to include(40)
      expect(subject).to include(10, 20)
    end
    it { is_expected.to include(10, 20, 30) }
    it { is_expected.to include(20, 10, 30) }
  end

  describe({ a: 2, b: 4 }) do
    it 'checks for key-value pairs in a hash' do
      expect(subject).to include(a: 2)
      expect(subject).to include(b: 4)
      expect(subject).not_to include(c: 6)
      expect(subject).to include(a: 2, b: 4)
    end

    it { is_expected.to include(a: 2) }
    it { is_expected.to include(b: 4) }
    it { is_expected.not_to include(c: 6) }
    it { is_expected.to include(a: 2, b: 4) }

    it 'checks for simple key existence in a hash' do
      expect(subject).to have_key(:a)
      expect(subject).to have_key(:b)
      expect(subject).not_to have_key(:c)

      # or using the `include` matcher
      expect(subject).to include(:a)
      expect(subject).to include(:b)
      expect(subject).not_to include(:c)
      expect(subject).to include(:a, :b)
    end

    it { is_expected.to have_key(:a) }
    it { is_expected.to include(:a) }
  end
end
