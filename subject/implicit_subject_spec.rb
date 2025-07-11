describe Hash do 
  # let(:my_hash) { {} } # same as let(:my_hash) { Hash.new }
  # do not need to do the above
  # let(:subject) { Hash.new } # this happens behind the scenes since our test subject is Hash 
  
  # before (:context) do 
  #   puts '================== Printing Subject (Hash) =========================='
  #   # This will not work in before(:context) because subject is not defined yet. 
  #   # RuntimeError:
  #   #  subject accessed in a `before(:context)` hook at:
  #   #    /Users/auhunt/dev/rubydubydoo/implicit_subject_spec.rb:7:in `block (2 levels) in <top (required)>'
    
  #   #  `let` and `subject` declarations are not intended to be called
  #   #  in a `before(:context)` hook, as they exist to define state that
  #   #  is reset between each example, while `before(:context)` exists to
  #   #  define state that is shared across examples in an example group.
  #   puts subject 
  #   puts subject.class
  #   puts subject.inspect
  #   puts subject.length
  #   puts subject.empty?
  # end
  # 

  before (:example) do
    puts '================== Printing Subject (Hash) =========================='
    puts subject
    puts subject.class
    puts subject.inspect
    puts subject.length
    puts subject.empty?
  end

  it 'is empty' do
    expect(subject.empty?).to be true 
    expect(subject).to be_empty 
    expect(subject.length).to eq(0)
  end

  context 'subject isolation testing' do 
    it 'allows adding key-value pairs' do
      subject[:key] = 'value'
      expect(subject[:key]).to eq('value')
      expect(subject.length).to eq(1)
      expect(subject.empty?).to be false
      puts 'Added key-value pair to subject.'
      puts subject
    end

    it 'is empty for new example' do  
      # This will not have the key-value pair from the previous example
      expect(subject.empty?).to be true 
      expect(subject.length).to eq(0)
      puts 'This is a new example, subject should be empty again.'
    end
  end
end