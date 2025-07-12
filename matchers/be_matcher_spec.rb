

# Checking Truthy/Falsy/Nil values in Ruby
#
# Easy to remember:
# - Truthy: Everything except false and nil.
# - Falsy: Only false and nil.
RSpec.describe 'Be Matchers' do
  puts 'What is a truthy value?'
  puts 'In Ruby, everything is truthy except false and nil.'

  puts 'What is a falsy value?'
  puts 'In Ruby, the only falsy values are false and nil.'

  puts 'What is a nil value?'
  puts 'In Ruby, nil is a special object that represents "nothing" or "nothingness".'

  puts 'What is the difference between nil and false?'
  puts 'In Ruby, nil is an object that represents "nothing", while false is a boolean value that represents "not true".'

  puts 'What is the difference between truthy and falsy values?'
  puts 'Truthy values are all values that are not false or nil, while falsy values are only false and nil.'

  it 'checks if a value is truthy' do
    expect(true).to be_truthy
    expect(1).to be_truthy
    expect(0).to be_truthy # In Ruby, 0 is truthy
    expect(-1).to be_truthy
    expect('Hello').to be_truthy
    expect([]).to be_truthy
    expect({}).to be_truthy
  end

  it 'checks if a value is falsy' do
    expect(false).to be_falsy
    expect(nil).to be_falsy

    expect(1.negative?).to be_falsy # This will pass because 0 > 1 is false
    expect([].nil?).to be_falsy # This will pass because an empty array is not equal to nil
    expect({}.nil?).to be_falsy # This will pass because an empty hash is not equal to nil
  end

  it 'checks if empty arrays and hashes are truthy' do
    expect([]).to be_truthy
    expect({}).to be_truthy
    puts 'Empty arrays and hashes are truthy in Ruby, even though they are empty.'
  end

  it 'checks if a value is nil' do
    expect(nil).to be_nil # the only value that is nil in Ruby
    expect(false).not_to be_nil
    expect(0).not_to be_nil
    my_hash = { key: 'value' }
    expect(my_hash).not_to be_nil # Hashes are not nil
    expect(my_hash[:missing_key]).to be_nil # Accessing a missing key returns nil
  end

  it 'checks if a value is not nil' do
    expect(1).not_to be_nil
    expect('Hello').not_to be_nil
  end
end
