# Polymorphism - we want to test that an object responds to a method, where the object may be of different types
class Vehicle
    attr_accessor :color, :mileage, :make, :model, :year, :age, :safe, :describe
    def safe?
        @safe
    end
    
    def start_engine
        puts "Starting the engine"
    end

    def stop_engine
        puts "Stopping the engine"
    end

    def describe 
        # return hash of vehicle attributes
        {
            color: @color,
            mileage: @mileage,
            make: @make,           
            model: @model,
            year: @year,
            age: @age,
            safe: @safe
        }
    end

    def initialize(color: 'black', mileage: 0, make: 'Toyota', model: 'Tacoma', year: '2021', safe: true)
        @color = color
        @mileage = mileage
        @make = make    
        @model = model
        @year = year
        @safe = safe
        # calculate age based on the current year
        current_year = Time.now.year
        @age = current_year - year
        puts "Your #{@color} Jeep #{@model} is #{@age} years old at #{@mileage} miles, manufactured in #{@year}."
    end  

    # instance methods for Vehicle class

    def repaint(new_color)
        puts "Repainting #{@make} #{@model} from #{@color} to #{new_color}."
        # change the color of the Jeep
        puts "Your Jeep is now #{new_color}."
        @color = new_color
    end

    def drive(miles)
        puts "Driving #{@make} #{@model} for #{miles} miles."
        @mileage += miles
        puts "Your Jeep now has #{@mileage} miles."
    end

    def hold_for_n_years(n_years)
        puts "Holding #{@make} #{@model} for #{n_years} years."
        @age += n_years
        puts "Your #{@make} #{@model} is now #{@age} years old."
    end
end

class Truck < Vehicle
    def initialize(mileage: 0, cargo_capacity: 0, make: 'Ford', model: 'F-150', year: 2025, color: 'red', safe: true)
        @cargo_capacity = cargo_capacity
        # invoke parent class's initialize method
        super(
            color: color,
            mileage: mileage,
            make: make,
            model: model,
            year: year,
            safe: safe
        )
    end
end
class Motorcycle < Vehicle
    def initialize(helmet_included: false, ccs: 500, mileage: 0, make: 'Harley-Davidson', model: 'Street 750', year: 2020, color: 'black', safe: true)
        @helmet_included = helmet_included
        @ccs = ccs
        super(
            color: color,
            mileage: mileage,
            make: make,
            model: model,
            year: year,
            safe: safe
        )
    end
end

class Jeep < Vehicle
    def initialize(off_road_capable: true, top_type: 'soft', mileage: 0, make: 'Jeep', model: 'Wrangler', year: 2020, color: 'green', safe: true)
        @off_road_capable = off_road_capable
        @top_type = top_type
        super(
            color: color,
            mileage: mileage,
            make: make,
            model: model,
            year: year,
            safe: safe,
        )
    end
end

RSpec.describe Vehicle do

    let(:vehicle) { Vehicle.new(color: 'blue', mileage: 0, make: 'Make', model: 'Model', year: 2020) }
    subject { vehicle }

    it 'responds to the repaint method' do
        expect(vehicle).to respond_to(:repaint)
    end
    
    it 'responds to the drive method' do
        expect(vehicle).to respond_to(:drive)
    end
    
    it 'responds to the hold_for_n_years method' do 
        expect(vehicle).to respond_to(:hold_for_n_years)
    end
    
    it 'responds to start_engine method' do
        expect(vehicle).to respond_to(:start_engine)
    end
    
    it 'responds to stop_engine method' do
        expect(vehicle).to respond_to(:stop_engine)
    end
    
    it { is_expected.to respond_to(:color) }
    it { is_expected.to respond_to(:mileage) }
    it { is_expected.to respond_to(:make) }
    it { is_expected.to respond_to(:model) }
    it { is_expected.to respond_to(:year) }
    it { is_expected.to respond_to(:age) }  
    it { is_expected.to respond_to(:safe) } 
end