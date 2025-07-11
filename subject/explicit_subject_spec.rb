RSpec.describe Hash do 
  before (:context) do 
    puts 'Demonstrating explicit subject and subject aliasing in RSpec'
    puts 'The subject is defined as a Hash with name and age keys.'
    puts 'bob is an alias for the subject, also defined as a Hash with name and age keys.'
    puts 'This is different from let, which is used for lazy evaluation.'
  end
  subject(:bob) do 
    { name: 'Bob', age: 30 }
  end

  context 'subject alias' do
    it 'subject has a name' do
      expect(subject[:name]).to eq('Bob')
    end

    it 'subject has an age' do
      expect(subject[:age]).to eq(30)
    end
  end

  context 'bob alias' do
    it 'has a name' do
      expect(bob[:name]).to eq('Bob')
    end

    it 'has an age' do
      expect(bob[:age]).to eq(30)
    end
  end 
end 


RSpec.describe Array do 
  before (:context) do 
    puts 'Demonstrating explicit subject aliasing in RSpec'
    puts 'The subject is defined as an Array with two elements: name and age.'
    puts 'sally is an alias for the subject, also defined as an Array with two elements: name and age.'
    puts 'This is different from let, which is used for lazy evaluation.'
  end

  subject(:sally) do 
    ['Sally', 25]
  end

  context 'subject alias' do
    it 'has a length of 2' do 
      expect(subject.length).to eq(2)
    end

    it 'can be modified with pop' do 
      subject.pop
      expect(subject.length).to eq(1)
      expect(subject).to eq(['Sally'])
    end

    it 'is equal to sally' do 
      expect(subject).to eq(sally)
    end

    it 'has a length of 2 in a separate example' do
      expect(subject.length).to eq(2)
    end
    
    it 'has a name' do
      expect(subject[0]).to eq('Sally')
    end

    it 'has an age' do
      expect(subject[1]).to eq(25)
    end
  end
end

# One liner syntax 
# 
RSpec.describe 'One-liner subject aliasing' do 
  before (:context) do 
    puts ''
    puts '========================= One-liner subject aliasing =========================='
    puts 'Demonstrating one-liner subject aliasing in RSpec'
    puts 'The subject is defined as a number 5.'
  end 

  subject { 5 } 

  context 'with classic syntax' do 
    it 'is a number' do 
      expect(subject).to be_a(Integer)
    end
    it 'is equal to 5' do
      expect(subject).to eq(5)
    end
  end

  context 'with one-liner syntax' do
    it { is_expected.to be_a(Integer) }
    it { is_expected.to eq(5) }
  end
end