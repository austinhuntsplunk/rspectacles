

# Spies are used to track method calls on real objects, allowing you to verify interactions without changing the object's behavior.
# They are useful for verifying that certain methods were called with specific arguments, without altering the method's behavior.
# Spies are often used in conjunction with `allow` to set up expectations on real objects.

# NOTE: Doubles vs Spies
# a double places the expectation before the method, a spy places the expectation after the method has been called.

RSpec.describe 'Spies' do
  let(:animal) { spy('animal') }
  it 'confirms that a message has been received' do
    animal.eat_food
    expect(animal).to have_received(:eat_food)
    expect(animal).not_to have_received(:sleep) # sleep was never called

    # Never had to declare any of the methods or implementations, just had to
    # keep track of the method calls; did it receive the method?
  end

  it 'resets between examples' do
    # spy animal is reinstantiated for each example
    expect(animal).not_to have_received(:eat_food) # reset between examples
    animal.sleep
    expect(animal).to have_received(:sleep)
  end

  it 'retains the same functionality as a regular double' do
    animal.eat_food
    animal.eat_food
    animal.eat_food('fish')
    expect(animal).to have_received(:eat_food).exactly(3).times
    expect(animal).to have_received(:eat_food).with('fish').exactly(1).time
  end
end

require_relative '../classes/garage'
require_relative '../classes/vehicle'

RSpec.describe Garage do
  let(:car) { instance_double(Vehicle) }

  # not interested in vehicle functionality, just on its interaction with the garage

  before do
    # This before block sets up the spy on the car instance before each test run
    allow(Vehicle).to receive(:new).and_return(car)
    allow(car).to receive(:describe).and_return(
      {
        color: 'blue',
        mileage: 10_000,
        make: 'Honda',
        model: 'Civic',
        year: 2020,
        age: Time.now.year - 2020,
        safe: true
      }
    )
  end

  it 'adds a vehicle to the garage' do
    garage = Garage.new
    # Use the park method that exists in Garage class
    description = car.describe
    puts "Description of the car: #{description.inspect}"

    # not actually new. calles Vehicle.new but returns our car spy.
    new_car = garage.build_new_car(description)
    puts "New car built: #{new_car.inspect}"
    expect(garage.vehicles).to include(car)
    # Verify that Vehicle.new was called with the expected arguments
    expect(Vehicle).to have_received(:new).with(
      # Alpha order of the keys in the hash is the order in which they are actually
      # passed to the Vehicle constructor
      age: Time.now.year - 2020,
      color: 'blue',
      make: 'Honda',
      mileage: 10_000,
      model: 'Civic',
      safe: true,
      year: 2020
    ).exactly(1).time
    expect(new_car).to eq(car) # Ensure the new car has same values as spy
    expect(new_car).to equal(car) # Since we've stubbed the Vehicle.new method to return the same object (car), they'll be the same object
  end
end
