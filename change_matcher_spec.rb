class Jeep 
  attr_accessor :color, :mileage, :model, :year , :age
  def initialize(color, mileage, model, year)
    @color = color
    @mileage = mileage
    @model = model
    @year = year
    # calculate age based on the current year
    current_year = Time.now.year
    @age = current_year - year
    puts "Your #{@color} Jeep #{@model} is #{@age} years old at #{@mileage} miles, manufactured in #{@year}."
  end

  def repaint(new_color)
    puts "Repainting Jeep from #{@color} to #{new_color}."
    # change the color of the Jeep
    puts "Your Jeep is now #{new_color}."
    @color = new_color
  end

  def drive(miles)
    puts "Driving #{@model} for #{miles} miles."
    @mileage += miles
    puts "Your Jeep now has #{@mileage} miles."
  end

  def hold_for_n_years(n_years)
    puts "Holding Jeep for #{n_years} years."
    @age += n_years
    puts "Your Jeep is now #{@age} years old."
  end
 
end

# change matcher: allows you to test state changes in an object or variable
RSpec.describe 'Change Matcher' do
  let(:nums) { [1, 2, 3] }
  let(:hash) { { a: 1, b: 2 } }
  let(:jeep) { Jeep.new('blue', 189000, 'Wrangler', 1999) }
  
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