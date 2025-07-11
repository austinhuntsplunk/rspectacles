RSpec.describe 'Comparison Matchers' do 
  it 'allows for comparison with built-in Ruby matchers' do 
    expect(5).to be > 3
    expect(10).to be >= 10
    expect(11).to be >= 10
    expect(7).to be < 8
    expect(4).to be <= 4
    expect(3).to be <= 4
    expect(5).to be == 5
    expect(5).to be === 5 # This is the same as == in Ruby
  end

  it 'demonstrates == versus ===' do
    expect(5 == 5).to be true
    expect(5 === 5).to be true # === is used for case equality, but behaves like == for numbers
    expect(5 == '5').to be false # Different types, so false
    expect(5 === '5').to be false # Different types, so false
  end

  describe 100 do
    before(:example) do 
      puts "The subject of this block is the number #{subject}."
      puts 'It will be used to demonstrate comparison matchers.'
    end
    it { is_expected.to be > 50 }
    it { is_expected.not_to be > 100 }

    it 'is greater than 50' do
      expect(subject).to be > 50
    end

    it 'is less than 200' do
      expect(subject).to be < 200
    end

    it 'is equal to itself' do
      expect(subject).to be == subject
    end

    it 'is not equal to 50' do
      expect(subject).not_to be == 50
    end

    it 'is not equal to 150' do
      expect(subject).not_to be == 150
    end
  end
end