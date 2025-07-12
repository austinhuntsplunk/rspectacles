

RSpec.describe 'allow method spec' do
  it 'can customize return values for methods' do
    calculator = double('Calculator')
    allow(calculator).to receive(:add).and_return(15)

    expect(calculator.add(5, 10)).to eq(15)
    expect(calculator.add(10)).to eq(15)
    expect(calculator.add('hello')).to eq(15)
    expect(calculator.add(-1, -2, -94)).to eq(15)
  end
  it 'can stub methods on a real object' do
    arr = [1, 2, 3]
    allow(arr).to receive(:size).and_return(10)
    expect(arr.size).to eq(10)
    expect(arr.size).to eq(10)
    arr.push(4)
    expect(arr.size).to eq(10)

    # fake method
    allow(arr).to receive(:fake_method).and_return('This is a fake method!')
    expect(arr.fake_method).to eq('This is a fake method!')
  end
  it 'can return multiple values in sequence' do
    # Allows one to focus on one specific behavior of an object for testing without loading full
    # implementation into memory
    mock_array = double('MockArray')
    allow(mock_array).to receive(:pop).and_return(:c, :b, nil)
    expect(mock_array.pop).to eq(:c)
    expect(mock_array.pop).to eq(:b)
    expect(mock_array.pop).to be_nil
    expect(mock_array.pop).to be_nil
    expect(mock_array.pop).to be_nil
    expect(mock_array.pop).to be_nil # continues returning nil
  end
end
