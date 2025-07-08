RSpec.describe Array do 
  before(:example) do 
    puts subject.inspect 
  end

  context 'testing Array subject' do
    it 'is empty' do 
      expect(subject.empty?).to be true 
      expect(subject.length).to eq(0)
    end
    it 'is an Array instance' do 
      expect(subject).to be_an_instance_of(Array)
      expect(subject.class).to eq(Array)
    end

    context 'testing Array subject isolation' do
      it 'allows adding elements' do 
        subject.push(1) # or subject << 1
        expect(subject).to include(1)
        expect(subject.length).to eq(1)
        expect(subject.empty?).to be false
      end

      it 'is empty for new example' do  
        # This will not have the element from the previous example
        expect(subject.empty?).to be true 
        expect(subject.length).to eq(0)
      end
    end
  end

  it 'can be created with a literal' do 
    arr = [1, 2, 3]
    expect(arr).to be_an_instance_of(Array)
    expect(arr).to eq([1, 2, 3])
  end

  it 'can be created with Array.new' do 
    arr = Array.new(3, 'default')
    expect(arr).to eq(['default', 'default', 'default'])
    expect(arr.length).to eq(3)
  end

  it 'can be created with Array.new without arguments' do 
    arr = Array.new
    expect(arr).to eq([])
    expect(arr.length).to eq(0)
  end
end

RSpec.describe 'Array of 2 elements' do 
  subject { [1, 2]}
  it 'is equal to [1, 2]' do
    expect(subject).to eq([1, 2])
  end
  it { is_expected.to eq([1, 2]) } # shorthand for the above
end