# Mocking and Test Doubles

This folder demonstrates RSpec's comprehensive mocking and stubbing capabilities, essential for creating isolated, fast, and reliable unit tests. From basic doubles to advanced spy patterns, these examples cover the full spectrum of test double usage.

## Overview

Mocking in RSpec allows you to:
- **Create test doubles** - Fake objects that stand in for real ones
- **Stub methods** - Define return values for method calls
- **Set expectations** - Verify that methods are called with specific arguments
- **Isolate units** - Test code in isolation from dependencies
- **Control external dependencies** - Mock APIs, databases, file systems

## Files and Concepts

### `double_spec.rb`
Introduction to creating and using basic test doubles (mocks) in RSpec.

**Key Features:**
- `double()` - Create a test double object
- Predefined method responses
- Method call verification
- Error handling for undefined methods
- Basic stubbing with `allow().to receive()`

### `allow_spec.rb`
Demonstrates the `allow` method for stubbing without expectations.

**Key Concepts:**
- Method stubbing with return values
- Conditional return values
- Stubbing with blocks and calculations
- Multiple return values
- Exception stubbing

### `instance_doubles_spec.rb`
Shows how to create instance doubles that verify against real class interfaces.

**Features:**
- `instance_double()` - Type-safe test doubles
- Interface verification against real classes
- Prevention of stale mocks
- Attribute stubbing
- Method signature validation

### `class_double_spec.rb`
Explores class doubles for mocking class methods and constants.

**Key Concepts:**
- `class_double()` - Mock entire classes
- Class method stubbing
- `as_stubbed_const` - Replace constants during tests
- Validation against real class methods
- Testing class-level interactions

### `spies_spec.rb`
Comprehensive guide to spy objects for after-the-fact verification.

**Advanced Features:**
- `spy()` - Objects that track all method calls
- `have_received()` - Post-execution verification
- Garage and Vehicle interaction testing
- Real object collaboration testing
- Method call frequency verification

### `movie_spec.rb`
Real-world example testing movie production with actor coordination.

**Complex Patterns:**
- Multiple object interactions
- State-dependent behavior testing
- Method call orchestration
- Output verification
- Conditional execution testing

### `matching_arguments_spec.rb`
Advanced argument matching and verification techniques.

**Features:**
- Exact argument matching
- Pattern matching with matchers
- `anything` and `a_kind_of` matchers
- Block argument verification
- Complex argument validation

## Core Mocking Concepts

### Test Doubles
Test doubles are fake objects that substitute for real dependencies:

```ruby
# Create a simple double
user_double = double('User')

# Create a double with preset methods
user_double = double('User', name: 'John', age: 30)

# Use in tests
allow(user_double).to receive(:save).and_return(true)
expect(user_double).to receive(:destroy).once
```

### Stubbing vs. Mocking
- **Stubbing** (`allow`) - Define what methods return, don't verify calls
- **Mocking** (`expect`) - Verify that methods are called with specific arguments

```ruby
# Stubbing - just define behavior
allow(user).to receive(:name).and_return('John')

# Mocking - verify the call happens
expect(user).to receive(:save).with(hash_including(name: 'John'))
```

### Spies vs. Doubles
- **Doubles** - Set expectations before method calls
- **Spies** - Verify interactions after method calls

```ruby
# Double approach
expect(logger).to receive(:info).with('Starting process')
service.process

# Spy approach  
logger = spy('Logger')
service.process
expect(logger).to have_received(:info).with('Starting process')
```

## Advanced Mocking Techniques

### Instance Doubles (Recommended)
```ruby
# Verifies against real class interface
user_double = instance_double('User', name: 'John', save: true)

# Will fail if User doesn't have these methods
expect(user_double.name).to eq('John')
```

### Class Doubles
```ruby
# Mock entire classes
user_class = class_double('User', create: user_instance)
expect(user_class).to receive(:create).with(name: 'John')
```

### Argument Matching
```ruby
# Exact arguments
expect(service).to receive(:process).with('exact', 'arguments')

# Argument matchers
expect(logger).to receive(:log).with(anything, hash_including(level: 'error'))
expect(api).to receive(:call).with(a_string_matching(/user-\d+/))

# Block arguments
expect(processor).to receive(:handle) do |arg|
  expect(arg).to be_a(Hash)
  expect(arg[:id]).to be > 0
end
```

### Complex Return Values
```ruby
# Different returns on successive calls
allow(user).to receive(:valid?).and_return(true, false, true)

# Conditional returns
allow(service).to receive(:call) do |arg|
  arg > 0 ? 'positive' : 'negative'
end

# Raising exceptions
allow(service).to receive(:call).and_raise(StandardError, 'Something went wrong')
```

## Real-World Patterns

### Testing External Dependencies
```ruby
describe UserService do
  let(:email_service) { instance_double('EmailService') }
  let(:database) { instance_double('Database') }
  
  subject { UserService.new(email_service, database) }
  
  before do
    allow(email_service).to receive(:send_welcome_email)
    allow(database).to receive(:save).and_return(true)
  end
  
  it 'creates user and sends email' do
    result = subject.create_user(email: 'test@example.com')
    
    expect(database).to have_received(:save)
    expect(email_service).to have_received(:send_welcome_email)
    expect(result).to be_successful
  end
end
```

### Testing Object Collaborations
```ruby
describe Garage do
  let(:vehicle) { instance_double('Vehicle', color: 'red', make: 'Toyota') }
  
  it 'parks vehicles and tracks them' do
    garage = Garage.new
    garage.park(vehicle)
    
    expect(garage.vehicles).to include(vehicle)
  end
end
```

### Testing State-Dependent Behavior
```ruby
describe Movie do
  let(:actor1) { instance_double('Actor', ready?: true) }
  let(:actor2) { instance_double('Actor', ready?: false) }
  
  subject { Movie.new(cast: [actor1, actor2]) }
  
  context 'when all actors are ready' do
    before { allow(actor2).to receive(:ready?).and_return(true) }
    
    it 'shoots the scene' do
      expect { subject.shoot_scene('Action') }.to output(/Shooting/).to_stdout
    end
  end
  
  context 'when not all actors are ready' do
    it 'does not shoot the scene' do
      expect { subject.shoot_scene('Action') }.to output(/Cannot shoot/).to_stdout
    end
  end
end
```

## Running Tests

```bash
# Run all mocking tests
rspec mocking/

# Run specific mocking examples
rspec mocking/double_spec.rb
rspec mocking/spies_spec.rb
rspec mocking/movie_spec.rb

# Run with detailed mock verification
rspec mocking/ --format documentation
```

## Benefits of Mocking

### 1. **Isolation**
Test units in complete isolation from dependencies:
```ruby
# Test UserService without hitting database or email service
describe UserService do
  let(:user_repo) { instance_double('UserRepository') }
  let(:email_service) { instance_double('EmailService') }
  
  # Tests focus only on UserService logic
end
```

### 2. **Speed**
Avoid slow operations like database calls, API requests:
```ruby
# Fast test - no actual HTTP calls
allow(http_client).to receive(:get).and_return(mock_response)
```

### 3. **Reliability**
Tests don't fail due to external service issues:
```ruby
# Won't fail if external API is down
allow(external_api).to receive(:fetch_data).and_return(test_data)
```

### 4. **Edge Case Testing**
Easily test error conditions:
```ruby
# Test error handling without causing real errors
allow(service).to receive(:call).and_raise(Network::TimeoutError)
```

## Best Practices

### 1. **Use Instance Doubles**
Prefer `instance_double` over `double` for type safety:
```ruby
# Good - will fail if User interface changes
user = instance_double('User', name: 'John')

# Avoid - no interface verification
user = double('User', name: 'John')
```

### 2. **Mock at the Boundary**
Mock external dependencies, not internal collaborators:
```ruby
# Good - mock external service
expect(payment_gateway).to receive(:charge)

# Avoid - mocking internal methods of same class
expect(subject).to receive(:internal_helper_method)
```

### 3. **Verify Important Interactions**
Use expectations for critical side effects:
```ruby
# Important - verify email is sent
expect(mailer).to receive(:send_notification)

# Less important - don't always need to verify
allow(logger).to receive(:debug)
```

### 4. **Keep Mocks Simple**
Complex mocks often indicate design problems:
```ruby
# Simple mock - good
user_double = instance_double('User', name: 'John', valid?: true)

# Complex mock - consider refactoring design
```

### 5. **Use Spies for Complex Interactions**
When testing multiple method calls, spies are cleaner:
```ruby
# Spy approach - cleaner for multiple verifications
service = spy('Service')
orchestrator.process
expect(service).to have_received(:step1)
expect(service).to have_received(:step2)
expect(service).to have_received(:step3)
```

## Common Pitfalls

1. **Over-mocking** - Mocking everything makes tests brittle
2. **Under-mocking** - Not isolating units properly
3. **Implementation coupling** - Mocking internal methods
4. **Stale mocks** - Mocks that don't match real object interfaces
5. **Inconsistent stubbing** - Different stubs in different tests

## Integration with Other RSpec Features

- **Shared examples** - Share mocking patterns across tests
- **Hooks** - Set up common mocks in `before` blocks
- **Let declarations** - Create reusable test doubles
- **Custom matchers** - Create domain-specific mock expectations
- **Metadata** - Conditionally apply mocking strategies

## Testing Strategies

### Unit Testing with Mocks
```ruby
describe OrderProcessor do
  let(:payment_service) { instance_double('PaymentService') }
  let(:inventory) { instance_double('Inventory') }
  let(:notification_service) { instance_double('NotificationService') }
  
  subject { OrderProcessor.new(payment_service, inventory, notification_service) }
  
  # Test the orchestration logic without external dependencies
end
```

### Integration Testing with Selective Mocking
```ruby
describe 'Order flow integration' do
  # Use real objects for some parts, mocks for external services
  let(:external_payment_api) { instance_double('PaymentAPI') }
  
  # Test with real database but mocked external API
end
```

## Next Steps

- Learn about verifying doubles for better mock safety
- Explore spy objects for complex interaction testing
- Study advanced argument matching techniques
- Practice mocking in different architectural patterns (MVC, Service Objects, etc.)
- Understand when to mock vs. when to use real objects
- Master the balance between isolated unit tests and integration tests
