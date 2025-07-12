

RSpec.describe 'Nested Hooks' do
  before(:context) do
    puts ''
    puts '==========================OUTER BEFORE CONTEXT HOOK =========================='
    puts 'This hook runs before any examples in the context are executed.'
    puts 'Use this hook to set up any state or context that is shared across examples.'
    puts ''
  end

  before(:example) do
    puts ''
    puts '========================== OUTER BEFORE EXAMPLE HOOK =========================='
    # print example name
    puts "Running example: #{RSpec.current_example.description}"
    puts 'Use this hook to set up any state or context before the example runs.'
  end
  after(:example) do
    puts '=========================== OUTER AFTER EXAMPLE HOOK =========================='
  end

  it 'does basic math' do
    expect(2 + 2).to eq(4)
    puts 'This is a basic math example.'
  end

  context 'with condition A' do
    before(:context) do
      puts '========================== INNER BEFORE CONTEXT HOOK =========================='
      puts 'This hook runs before any examples in the context are executed.'
      puts 'Use this hook to set up any state or context that is shared across examples.'
      puts ''
    end
    before(:example) do
      puts ''
      puts '========================== INNER BEFORE EXAMPLE HOOK =========================='
      # print example name
      puts "Running example: #{RSpec.current_example.description}"
      puts 'Use this hook to set up any state or context before the example runs.'
    end

    it 'does multiplication' do
      expect(9 * 9).to eq(81)
      puts 'This is a more complex math example.'
    end
    it 'does subtraction with negative output' do
      expect(9 - 10).to eq(-1)
      puts 'This is a subtraction example with a negative output.'
    end
  end
end
