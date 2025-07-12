

require_relative './vehicle'
class Garage
  attr_reader :vehicles

  # Initialize an empty array to hold parked vehicles
  # The park method can accept either an instance of Vehicle or a class that inherits from Vehicle
  def initialize
    @vehicles = []
  end

  def park(vehicle)
    puts "Parking vehicle: #{vehicle.class}"
    @vehicles << vehicle
  end

  def build_new_car(description)
    # description is a hash with keys like :color, :mileage, :make, :model, :year, :age, :safe
    puts "Building new car to match description: #{description.inspect}"
    vehicle = Vehicle.new(
      color: description[:color],
      mileage: description[:mileage],
      make: description[:make],
      model: description[:model],
      year: description[:year],
      age: description[:age],
      safe: description[:safe]
    )
    @vehicles << vehicle
    vehicle # Return the newly created vehicle instance
  end

  def retrieve(vehicle)
    @vehicles.delete(vehicle)
  end
end
