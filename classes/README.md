# Classes and Object-Oriented Testing

This folder contains examples of testing object-oriented Ruby code, including class behavior, polymorphism, object interactions, and real-world class design patterns.

## Overview

Object-oriented testing in RSpec focuses on:
- Testing class behavior and state management
- Verifying object interactions and collaborations
- Testing inheritance and polymorphism
- Ensuring proper encapsulation and interfaces
- Testing complex object relationships

## Files and Concepts

### `vehicle.rb`
A comprehensive example of inheritance and polymorphism with multiple vehicle types.

**Object-Oriented Concepts:**
- **Base class (`Vehicle`)** - Common behavior and attributes
- **Inheritance** - `Truck`, `Motorcycle`, `Jeep` inherit from `Vehicle`
- **Polymorphism** - All vehicles respond to common methods (`start_engine`, `stop_engine`)
- **Encapsulation** - Private state with public interfaces
- **Keyword arguments** - Modern Ruby initialization patterns
- **Factory methods** - Multiple ways to create instances
- **Age calculation** - Dynamic attribute computation

**Key Features:**
- `attr_accessor` for property access
- Custom predicate method (`safe?`)
- Instance variable management
- Class factory methods (`Vehicle.default`, `Vehicle.sports_car`)
- Polymorphic method signatures across subclasses

### `garage.rb`
Demonstrates object collaboration and flexible method design.

**Key Concepts:**
- **Object collaboration** - Garage manages Vehicle instances
- **Flexible method signatures** - `park` method accepts various inputs
- **Duck typing** - Uses `respond_to?` instead of strict type checking
- **Collection management** - Managing arrays of objects
- **Method overloading simulation** - Single method handling multiple use cases

**Features:**
- Parks existing vehicle instances
- Creates and parks vehicles from classes
- Retrieves vehicles from storage
- Compatible with test doubles and real objects

### `card_game.rb`
Complete card game implementation showing complex object interactions.

**Object-Oriented Patterns:**
- **Player class** - Manages player state and hand
- **Deck class** - Card collection with shuffling and dealing
- **Game logic** - Orchestrates player and deck interactions
- **Class methods** - Factory methods for deck creation
- **State management** - Tracking game state across turns

### `card_spec.rb`
Comprehensive test suite for the card game classes.

**Testing Patterns:**
- **Class behavior testing** - Verifying method functionality
- **State change testing** - Using `change` matcher
- **Object interaction testing** - Verifying collaborations
- **Edge case testing** - Boundary conditions and error states

## Key Testing Concepts

### Testing Class Behavior
```ruby
describe Vehicle do
  subject { Vehicle.new(color: 'red', mileage: 0, make: 'Toyota', model: 'Camry', year: 2020) }
  
  it { is_expected.to respond_to(:start_engine) }
  it { is_expected.to respond_to(:stop_engine) }
  it { expect(subject.color).to eq('red') }
end
```

### Testing Inheritance
```ruby
describe Truck do
  it 'inherits from Vehicle' do
    expect(Truck.new).to be_a(Vehicle)
  end
  
  it 'has truck-specific attributes' do
    truck = Truck.new(cargo_capacity: 1000)
    expect(truck.instance_variable_get(:@cargo_capacity)).to eq(1000)
  end
end
```

### Testing Polymorphism
```ruby
[Truck, Motorcycle, Jeep].each do |vehicle_class|
  describe vehicle_class do
    subject { vehicle_class.new }
    
    it { is_expected.to respond_to(:start_engine) }
    it { is_expected.to respond_to(:stop_engine) }
    it { is_expected.to be_a(Vehicle) }
  end
end
```

### Testing Object Collaborations
```ruby
describe Garage do
  let(:vehicle) { Vehicle.new(color: 'blue') }
  
  it 'stores parked vehicles' do
    garage = Garage.new
    garage.park(vehicle)
    expect(garage.vehicles).to include(vehicle)
  end
end
```

## Advanced OOP Testing Patterns

### Testing Factory Methods
```ruby
describe 'Vehicle factory methods' do
  describe '.default' do
    subject { Vehicle.default }
    
    it { expect(subject.make).to eq('Toyota') }
    it { expect(subject.model).to eq('Corolla') }
  end

  describe '.sports_car' do
    subject { Vehicle.sports_car }
    
    it { expect(subject.make).to eq('Ferrari') }
    it { expect(subject.color).to eq('red') }
  end
end
```

### Testing State Changes
```ruby
describe '#drive' do
  let(:vehicle) { Vehicle.new(mileage: 1000) }
  
  it 'increases mileage' do
    expect { vehicle.drive(100) }.to change(vehicle, :mileage).by(100)
  end
  
  it 'updates age when holding for years' do
    expect { vehicle.hold_for_n_years(2) }.to change(vehicle, :age).by(2)
  end
end
```

### Testing Duck Typing
```ruby
describe Garage do
  context 'with duck-typed objects' do
    let(:vehicle_like) { double('Vehicle', color: 'red', make: 'Honda') }
    
    it 'accepts objects that respond to vehicle methods' do
      garage = Garage.new
      result = garage.park(vehicle_like)
      expect(garage.vehicles).to include(vehicle_like)
    end
  end
end
```

## Running Tests

```bash
# Run all class tests
rspec classes/

# Run specific class tests
rspec classes/card_spec.rb
rspec classes/vehicle.rb  # Contains embedded RSpec tests

# Test specific patterns
rspec classes/ -e "polymorphism"
rspec classes/ -e "inheritance"
```

## Object-Oriented Testing Principles

### 1. Test Behavior, Not Implementation
```ruby
# Good - tests what the method does
it 'calculates age from year' do
  vehicle = Vehicle.new(year: 2020)
  expect(vehicle.age).to eq(Time.now.year - 2020)
end

# Avoid - tests internal implementation
it 'sets @age instance variable' do
  vehicle = Vehicle.new(year: 2020)
  expect(vehicle.instance_variable_get(:@age)).to be_present
end
```

### 2. Test Public Interface
```ruby
# Good - tests public methods
describe Vehicle do
  it { is_expected.to respond_to(:repaint) }
  it { is_expected.to respond_to(:drive) }
end

# Avoid testing private methods directly
```

### 3. Test Object Collaborations
```ruby
describe 'object interactions' do
  it 'coordinates between objects' do
    garage = Garage.new
    vehicle = Vehicle.new
    
    garage.park(vehicle)
    retrieved = garage.retrieve(vehicle)
    
    expect(retrieved).to eq(vehicle)
    expect(garage.vehicles).not_to include(vehicle)
  end
end
```

## Common Patterns

### Testing Initialization Flexibility
```ruby
describe Vehicle do
  context 'with default parameters' do
    subject { Vehicle.new }
    
    it { expect(subject.make).to eq('Toyota') }
    it { expect(subject.color).to eq('black') }
  end
  
  context 'with custom parameters' do
    subject { Vehicle.new(color: 'red', make: 'Honda') }
    
    it { expect(subject.color).to eq('red') }
    it { expect(subject.make).to eq('Honda') }
  end
end
```

### Testing Attribute Accessors
```ruby
describe 'attribute management' do
  subject { Vehicle.new(color: 'red') }
  
  it 'allows reading attributes' do
    expect(subject.color).to eq('red')
  end
  
  it 'allows modifying attributes' do
    subject.color = 'blue'
    expect(subject.color).to eq('blue')
  end
end
```

### Testing Predicates and State
```ruby
describe '#safe?' do
  context 'when vehicle is safe' do
    subject { Vehicle.new(safe: true) }
    it { is_expected.to be_safe }
  end
  
  context 'when vehicle is not safe' do
    subject { Vehicle.new(safe: false) }
    it { is_expected.not_to be_safe }
  end
end
```

## Integration with RSpec Features

- **Shared examples** - Test common behavior across classes
- **Custom matchers** - Create domain-specific assertions
- **Hooks** - Set up complex object graphs
- **Let declarations** - Create test data and collaborators
- **Instance doubles** - Mock object collaborations

## Best Practices

1. **Test one behavior per test** - Keep tests focused and clear
2. **Use descriptive context blocks** - Group related test scenarios
3. **Test edge cases** - Boundary conditions and error states
4. **Mock external dependencies** - Keep tests isolated and fast
5. **Test the interface, not internals** - Focus on public behavior
6. **Use factory methods** - Create consistent test objects
7. **Test object collaborations** - Verify how objects work together

## Real-World Applications

The classes in this folder demonstrate common real-world patterns:
- **Domain modeling** - Vehicle hierarchy represents real-world concepts
- **Service objects** - Garage manages and coordinates vehicles
- **Game logic** - Card game shows complex state management
- **Flexible APIs** - Methods that accept various input types
- **Factory patterns** - Multiple ways to create objects

## Next Steps

- Explore more complex inheritance hierarchies
- Learn about composition vs. inheritance trade-offs
- Practice testing observer patterns and callbacks
- Study testing strategies for domain-driven design
- Implement and test design patterns (Strategy, Factory, Observer)
