require_relative File.expand_path('../classes/vehicle.rb', __dir__)

# change matcher: allows you to test state changes in an object or variable
RSpec.describe 'Change Matcher' do
  let(:nums) { [1, 2, 3] }
  let(:hash) { { a: 1, b: 2 } }
  let(:jeep) { Jeep.new(
    color: 'blue',
    mileage: 189000,
    make: 'Jeep',
    model: 'Wrangler',
    year: 1999,
    safe: false
  ) }
  
  it 'tests if the size of an array changes' do
    expect { nums << 4 }.to change { nums.size }.by(1)
    expect { nums.pop }.to change { nums.size }.by(-1)
    expect { nums.clear }.to change { nums.size }.to(0)
  end

  it 'tests if value of a key changes in a hash' do 
    expect { hash[:c] = 3 }.to change { hash.size }.by(1)
    expect { hash[:a] = 10 }.to change { hash[:a] }.from(1).to(10)
    expect { hash.delete(:b) }.to change { hash.size }.by(-1)
  end

  it 'tests object state changes' do
    expect { jeep.repaint('red') }.to change { jeep.color }.from('blue').to('red')
    expect { jeep.drive(100) }.to change { jeep.mileage }.by(100)
    expect { jeep.hold_for_n_years(5) }.to change { jeep.age }.by(5)
  end

  it 'accepts negative changes' do 
    puts 'nums before pop:'
    puts nums.inspect
    expect { nums.pop }.to change { nums.size }.by(-1)
    puts 'nums after pop:'
    puts nums.inspect
    puts 'nums before shift:'
    puts nums.inspect
    expect { nums.shift }.to change { nums.size }.by(-1)
    puts 'nums after shift:'
    puts nums.inspect
  end
end