# Mocking and Test Doubles

This folder demonstrates RSpec's powerful mocking and stubbing capabilities, essential for creating isolated, fast, and reliable unit tests.

## Overview

Mocking in RSpec allows you to:
- **Create test doubles** - Fake objects that stand in for real ones
- **Stub methods** - Define return values for method calls
- **Set expectations** - Verify that methods are called with specific arguments
- **Isolate units** - Test code in isolation from dependencies

## Files and Concepts

### `double_spec.rb`
Introduction to creating and using test doubles (mocks) in RSpec.

**Key Features:**
- `double()` - Create a test double object
- `allow().to receive()` - Stub method calls
- `expect().to receive()` - Set method call expectations
- Method stubbing with return values
- Argument matching and verification

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

### Stubbing
Stubbing defines what methods return without caring if they're called:

```ruby
# Basic stubbing
allow(user).to receive(:name).and_return('John')

# Stubbing with different return values
allow(user).to receive(:valid?).and_return(true, false, true)

# Stubbing with blocks
allow(calculator).to receive(:add) { |a, b| a + b }

# Stubbing to raise errors
allow(service).to receive(:call).and_raise(StandardError, 'Something went wrong')
```

### Mocking (Expectations)
Mocking verifies that methods are called with specific arguments:

```ruby
# Expect method to be called
expect(user).to receive(:save)

# Expect method with specific arguments
expect(mailer).to receive(:send_email).with('user@example.com', 'Welcome!')

# Expect method called specific number of times
expect(logger).to receive(:info).exactly(3).times
expect(service).to receive(:process).once
expect(cache).to receive(:clear).at_least(2).times
```

## Common Patterns

### Testing External Dependencies
```ruby
describe UserService do
  let(:email_service) { double('EmailService') }
  subject { UserService.new(email_service) }
  
  describe '#create_user' do
    it 'sends welcome email' do
      expect(email_service).to receive(:send_welcome_email).with(user)
      subject.create_user(user_params)
    end
  end
end
```

### Stubbing Complex Objects
```ruby
describe OrderProcessor do
  let(:payment_gateway) { double('PaymentGateway') }
  let(:inventory) { double('Inventory') }
  
  before do
    allow(payment_gateway).to receive(:charge).and_return(true)
    allow(inventory).to receive(:available?).and_return(true)
    allow(inventory).to receive(:reserve)
  end
  
  it 'processes order successfully' do
    result = processor.process(order)
    expect(result).to be_successful
  end
end
```

### Partial Mocking
Mock some methods while keeping others real:

```ruby
describe User do
  let(:user) { User.new(email: 'test@example.com') }
  
  it 'sends notification after save' do
    allow(user).to receive(:save).and_return(true)
    expect(user).to receive(:send_notification)
    
    user.save_and_notify
  end
end
```

## Advanced Mocking Techniques

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

### Method Chaining
```ruby
# Stub method chains
allow(user).to receive_message_chain(:account, :balance).and_return(100)

# Equivalent to: user.account.balance => 100
```

### Null Objects
```ruby
# Create a null object that responds to any method
null_logger = double.as_null_object
null_logger.info('message')  # Won't raise error
null_logger.debug('message') # Won't raise error
```

## Running Tests

```bash
# Run all mocking tests
rspec mocking/

# Run specific mocking examples
rspec mocking/double_spec.rb

# Run with detailed mock verification
rspec mocking/ --format documentation
```

## Benefits of Mocking

### 1. **Isolation**
Test units in complete isolation from dependencies:
```ruby
# Test UserService without hitting the database or email service
describe UserService do
  let(:user_repo) { double('UserRepository') }
  let(:email_service) { double('EmailService') }
  
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

### 1. **Mock at the Boundary**
Mock external dependencies, not internal collaborators:
```ruby
# Good - mock external service
expect(payment_gateway).to receive(:charge)

# Avoid - mocking internal methods of same class
expect(subject).to receive(:internal_helper_method)
```

### 2. **Verify Important Interactions**
Use expectations for critical side effects:
```ruby
# Important - verify email is sent
expect(mailer).to receive(:send_notification)

# Less important - don't always need to verify
allow(logger).to receive(:debug)
```

### 3. **Keep Mocks Simple**
Complex mocks often indicate design problems:
```ruby
# Simple mock - good
user_double = double(name: 'John', valid?: true)

# Complex mock - consider refactoring
user_double = double do |d|
  allow(d).to receive(:complex_calculation) do |args|
    # 20 lines of complex logic
  end
end
```

### 4. **Use Verifying Doubles**
Prevent mocks from getting out of sync with real objects:
```ruby
# Verifying double - will fail if User doesn't have these methods
user_double = instance_double('User', name: 'John', save: true)
```

## Common Pitfalls

1. **Over-mocking** - Mocking everything makes tests brittle
2. **Under-mocking** - Not isolating units properly
3. **Implementation coupling** - Mocking internal methods
4. **Stale mocks** - Mocks that don't match real object interfaces

## Integration with Other RSpec Features

- **Shared examples** - Share mocking patterns across tests
- **Hooks** - Set up common mocks in `before` blocks
- **Let declarations** - Create reusable test doubles
- **Custom matchers** - Create domain-specific mock expectations

## Next Steps

- Learn about verifying doubles for better mock safety
- Explore spy objects for after-the-fact verification
- Study advanced argument matching techniques
- Practice mocking in different architectural patterns (MVC, Service Objects, etc.)
