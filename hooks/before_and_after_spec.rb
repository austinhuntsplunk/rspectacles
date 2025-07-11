RSpec.describe 'before and after hooks' do 
  before (:context) do 
    puts ''
    puts '========================== BEFORE CONTEXT HOOK =========================='
    puts 'This hook runs before any examples in the context are executed.'
    puts 'Use this hook to set up any state or context that is shared across examples.'
    puts ''  
    puts ''
  end

  after (:context) do 
    puts ''
    puts ''
    puts '========================== AFTER CONTEXT HOOK =========================='
    puts 'This hook runs after all examples in the context have completed.'
    puts 'Use this hook to clean up any state or context that was set up in the before hook.'
  end

  before (:example) do 
    puts ''
    puts '========================== BEFORE EXAMPLE HOOK =========================='
    # print example name 
    puts "Running example: #{RSpec.current_example.description}"
    puts "Use this hook to set up any state or context before the example runs."
  end

  after (:example) do 
    puts ''
    puts '========================== AFTER EXAMPLE HOOK =========================='
    puts "Completed example: #{RSpec.current_example.description}"
    puts "Use this hook to reset any state or clean up after the example."
  end
        
    
  it 'is just a random example' do 
    expect(5*4).to eq(20)
  end
  it 'is another random example' do
    expect(5*5).to eq(25)
  end
end