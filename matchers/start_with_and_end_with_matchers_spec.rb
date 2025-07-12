

RSpec.describe 'start_with and end_with matchers' do
  describe 'start_with matcher' do
    it 'checks if a string starts with a specific substring' do
      expect('hot chocolate').to start_with('hot')
      expect('hot chocolate').not_to start_with('chocolate')
    end
    describe 'hot chocolate' do
      it { is_expected.to start_with('hot') }
    end

    describe [:a, :b, :c, :d] do
      it { is_expected.to start_with(:a) }
      it { is_expected.to start_with(:a, :b) }
    end
  end

  describe 'end_with matcher' do
    it 'checks if a string ends with a specific substring' do
      expect('hot chocolate').to end_with('chocolate')
      expect('hot chocolate').not_to end_with('hot')
    end
    describe 'hot chocolate' do
      it { is_expected.to end_with('chocolate') }
    end

    describe [:a, :b, :c, :d] do
      it { is_expected.to end_with(:d) }
      it { is_expected.to end_with(:c, :d) }
    end
  end

  describe
end
