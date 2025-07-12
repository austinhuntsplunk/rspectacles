RSpec.describe 'Equality Matchers (eq, eql, equal)' do
  before(:context) do
    puts ''
    puts '========================= Equality Matchers =========================='
    puts 'Demonstrating equality matchers in RSpec: eq, eql, equal'
  end

  let(:integer) { 5 }
  let(:float) { 5.0 }
  let(:integer2) { 5 }
  let(:float2) { 5.0 }
  let(:string) { 'Hello' }
  let(:array) { [1, 2, 3] }
  let(:array2) { [1, 2, 3] } # Another array with same content
  let(:array3) { array  }
  let(:hash) { { key: 'value' } }

  describe 'eq matcher' do
    it 'checks value equality and ignores type' do
      expect(integer).to eq(float)
      expect(integer).not_to eq('5') # Strings not equal to integers
      expect(array).to eq([1, 2, 3]) # Arrays with same
      expect(array).to eq(array2) # Arrays with same content
      expect(array).to eq(array3) # array3 is the same object as array
      expect(hash).to eq({ key: 'value' }) # Hashes with same key-value pairs
      expect(string).to eq('Hello') # Strings with same content
    end
  end

  describe 'eql matcher' do
    it 'tests for value equality and type' do
      expect(integer).to eql(5)
      expect(float).not_to eql(integer) # This will fail because float is not an integer
      expect(integer).not_to eql('5') # This will fail because string is not an integer

      expect(float).to eql(5.0) # Float is equal to float
      expect(array).to eql([1, 2, 3]) # Arrays with same content
      expect(array).to eql(array2) # Arrays with same content
      expect(array).to eql(array3) # array3 is the same object as array
      expect(hash).to eql({ key: 'value' }) # Hashes with same key-value pairs
      expect(string).to eql('Hello') # Strings with same content
    end
  end

  describe 'equal matcher' do
    it 'tests for object identity' do
      expect(integer).to equal(integer2) # because integer2 is the same object as integer
      expect(float).to equal(float2) # float and float2 have same object identity
      expect(integer).to equal(5) # because 5 is not the same object as integer
      expect(integer).to equal(5)
      expect(float).not_to equal(integer) # because float is not the same object as integer
      expect(array).not_to equal([1, 2, 3]) # because array is not the same object as [1, 2, 3]
      expect(array).not_to equal(array2) # because array2 is the same object as array
      expect(array).to equal(array) # because array is the same object as itself
      expect(array).to equal(array3) # because array3 is the same object as array
      expect(hash).not_to equal({ key: 'value' }) # because hash is not the same object as { key: 'value' }
      expect(string).not_to equal('Hello') # because string is not the same object as 'Hello'
    end
  end

  describe 'be matcher (shorthand for equal)' do
    it 'checks object identity' do
      expect(integer).to be(integer2) # because integer2 is the same object as integer
      expect(float).to be(float2) # because float2 is the same object as float
      expect(integer).to be(5) # because 5 is not the same object as integer
      expect(array).not_to be([1, 2, 3]) # because array is not the same object as [1, 2, 3]
      expect(array).to be(array) # because array is the same object as itself
      expect(array).to be(array3) # because array3 is the same object as array
      expect(hash).not_to be({ key: 'value' }) # because hash is not the same object as { key: 'value' }
      expect(string).not_to be('Hello') # because string is not the same object as 'Hello'
    end
  end
end
