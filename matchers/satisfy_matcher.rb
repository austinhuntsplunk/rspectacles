

# Using satisfy matcher to create our own custom conditions
require_relative '../polymorphism/vehicle'
RSpec.describe 'Custom Conditions' do
  describe 'new vehicle' do
    let(:vehicle) do
      Vehicle.new(color: 'blue', mileage: 0, make: 'Make', model: 'Model', year: Time.now.year - 1, safe: true)
    end

    it 'is less than 2 years old' do
      current_year = Time.now.year
      expect(vehicle).to(satisfy { |v| current_year - v.year < 2 })
      # or using a block
      expect(vehicle).to satisfy('new vehicle') do |v|
        current_year - v.year < 2
      end
    end

    it 'has mileage less than 5000' do
      expect(vehicle).to(satisfy { |v| v.mileage < 5000 })
      # or using a block
      expect(vehicle).to satisfy('low mileage') do |v|
        v.mileage < 5000
      end
    end

    it 'is safe' do
      expect(vehicle).to(satisfy(&:safe?))
      # or
      expect(vehicle.safe?).to be true
      # or using a block
      expect(vehicle).to satisfy('safe vehicle'), &:safe?
    end
  end

  describe 'old vehicle' do
    let(:vehicle) do
      Vehicle.new(color: 'red', mileage: 100_000, make: 'OldMake', model: 'OldModel', year: 1990, safe: false)
    end
    it 'is more than 30 years old' do
      current_year = Time.now.year
      expect(vehicle).to(satisfy { |v| current_year - v.year > 30 })

      # or
      expect(vehicle).to satisfy('old vehicle') do |v|
        current_year - v.year > 30
      end
    end

    it 'has mileage more than 50000' do
      expect(vehicle).to(satisfy { |v| v.mileage > 50_000 })
      # or
      expect(vehicle).to satisfy('high mileage') do |v|
        v.mileage > 50_000
      end
    end
    it 'is not safe' do
      expect(vehicle).to(satisfy { |v| !v.safe? })
      # or
      expect(vehicle.safe?).to be false

      expect(vehicle).to satisfy('not safe') do |v|
        !v.safe?
      end
    end
  end
end

# Palindrome matcher
RSpec.describe 'Palindrome Matcher' do
  describe 'racecar' do
    it 'is a palindrome' do
      expect('racecar').to(satisfy { |word| word == word.reverse })
      # or using a block
      expect('racecar').to satisfy('palindrome') do |word|
        word == word.reverse
      end
    end
  end
  describe 'hello' do
    it 'is not a palindrome' do
      expect('hello').not_to(satisfy { |word| word == word.reverse })
      # or using a block
      expect('hello').not_to satisfy('not a palindrome') do |word|
        word == word.reverse
      end
    end
  end
end
