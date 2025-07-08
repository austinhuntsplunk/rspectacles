
# All of the referenced classes below (String, Array, Hash, SausageLength) have a length method. That should return an integer between 1 and 15
RSpec.shared_examples 'lengthable' do
  it 'has a length that is an integer' do 
    expect(subject.length).to be_a(Integer)
  end
  it 'has a length between 1 and 15' do
    expect(subject.length).to be_between(1, 15)
  end
end


RSpec.describe String do
  # The default subject for String is an empty string, but we can override it.
  subject { 'Hello, World!' }
  include_examples 'lengthable'
  it 'can be reversed' do
    expect(subject.reverse).to eq('!dlroW ,olleH')
  end
end

RSpec.describe Array do 
  subject { [1, 2, 3] }
  include_examples 'lengthable'
end

RSpec.describe Hash do
  subject { { name: 'Alice', age: 30 } }

  it 'has a name' do
    expect(subject[:name]).to eq('Alice')
  end

  it 'has an age' do
    expect(subject[:age]).to eq(30)
  end

  it 'can be modified' do
    subject[:age] = 31
    expect(subject[:age]).to eq(31)
  end

  include_examples 'lengthable'
end


class SausageLink 
  def length 
    # random integer between 1 and 10
    rand(1..10)
  end
end

RSpec.describe SausageLink do
  subject { described_class.new }
  include_examples 'lengthable'
end
 