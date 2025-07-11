# Classes and Object-Oriented Testing

This folder contains examples of testing object-oriented Ruby code, including class behavior, polymorphism, and object interactions.

## Overview

Object-oriented testing in RSpec focuses on:
- Testing class behavior and state
- Verifying object interactions
- Testing inheritance and polymorphism
- Ensuring proper encapsulation

## Files and Concepts

### `vehicle.rb`
A comprehensive example of object-oriented Ruby demonstrating:

**Object-Oriented Concepts:**
- **Base class (`Vehicle`)** - Common behavior and attributes
- **Inheritance** - `Truck`, `Motorcycle`, `Jeep` inherit from `Vehicle`
- **Polymorphism** - All vehicles respond to common methods
- **Encapsulation** - Private state with public interfaces
- **Keyword arguments** - Modern Ruby initialization patterns

**Key Features:**
- `attr_accessor` for property access
- Custom predicate method (`safe?`)
- Instance variable management
- Age calculation based on current year
- Polymorphic method signatures

### `card_spec.rb`
Tests for a Card class demonstrating:

**Testing Patterns:**
- Object initialization
- Attribute access and modification
- Method behavior verification
- State change testing

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
    expect(truck).to respond_to(:cargo_capacity)
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
  end
end
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

### 3. Test State Changes
```ruby
describe '#drive' do
  it 'increases mileage' do
    vehicle = Vehicle.new(mileage: 1000)
    expect { vehicle.drive(100) }.to change(vehicle, :mileage).by(100)
  end
end
```

## Common Patterns

### Testing Initialization
```ruby
describe '#initialize' do
  context 'with valid parameters' do
    subject { Vehicle.new(color: 'blue', mileage: 0, make: 'Honda', model: 'Civic', year: 2021) }
    
    it { expect(subject.color).to eq('blue') }
    it { expect(subject.mileage).to eq(0) }
    it { expect(subject.make).to eq('Honda') }
  end
  
  context 'with invalid parameters' do
    it 'raises an error when missing required params' do
      expect { Vehicle.new }.to raise_error(ArgumentError)
    end
  end
end
```

### Testing Attribute Accessors
```ruby
describe 'attribute accessors' do
  subject { Vehicle.new(color: 'red', mileage: 0, make: 'Toyota', model: 'Camry', year: 2020) }
  
  it 'allows reading color' do
    expect(subject.color).to eq('red')
  end
  
  it 'allows setting color' do
    subject.color = 'blue'
    expect(subject.color).to eq('blue')
  end
end
```

### Testing Predicates
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

## Running Tests

```bash
# Run all class tests
rspec classes/

# Run specific class tests
rspec classes/card_spec.rb

# Test just the Vehicle class behavior
rspec -e "Vehicle"
```

## Advanced OOP Testing

### Testing Class Methods
```ruby
describe '.class_method' do
  it 'returns expected value' do
    expect(Vehicle.total_count).to eq(0)
  end
end
```

### Testing Modules and Mixins
```ruby
module Drivable
  def drive
    # implementation
  end
end

describe Vehicle do
  it 'includes Drivable module' do
    expect(Vehicle.included_modules).to include(Drivable)
  end
end
```

### Testing Callbacks and Observers
```ruby
describe 'callbacks' do
  it 'calls update_mileage after drive' do
    expect(vehicle).to receive(:update_mileage)
    vehicle.drive(100)
  end
end
```

## Best Practices

1. **Test one behavior per test** - Keep tests focused
2. **Use descriptive context blocks** - Group related tests
3. **Test edge cases** - Boundary conditions and error states
4. **Mock external dependencies** - Keep tests isolated
5. **Test the interface, not internals** - Focus on public behavior

## Integration with Other RSpec Features

- **Shared examples** - Test common behavior across classes
- **Custom matchers** - Create domain-specific assertions
- **Hooks** - Set up complex object graphs
- **Let declarations** - Create test data and collaborators

## Next Steps

- Explore testing object collaborations and dependencies
- Learn about mocking and stubbing for isolated unit tests
- Practice testing more complex inheritance hierarchies
- Study testing design patterns like Factory and Builder
