# RSpec Contexts and Test Organization

This folder demonstrates RSpec's context and organization features, showing how to structure tests effectively using `describe`, `context`, `subject`, and `let` declarations.

## Overview

Test organization in RSpec helps create clear, maintainable test suites through:
- **Context blocks** - Grouping related test scenarios
- **Described class** - Referencing the class under test
- **Subject management** - Defining what you're testing
- **Let declarations** - Creating test data and setup

## Files and Concepts

### `array_spec.rb`
Demonstrates testing Ruby's Array class with different contexts and subject isolation.

**Key Features:**
- Implicit subject (`Array.new`) when describing a class
- Subject isolation between examples
- Context nesting for related scenarios
- Before hooks for debugging output
- Custom subject definitions for specific test scenarios

**Example Patterns:**
```ruby
RSpec.describe Array do
  # Implicit subject is Array.new

  context 'when empty' do
    it { is_expected.to be_empty }
  end

  context 'with elements' do
    subject { [1, 2, 3] }
    it { is_expected.to include(2) }
  end
end
```

### `context_spec.rb`
Shows how to use `context` blocks to organize tests by different scenarios and conditions.

**Key Features:**
- Grouping tests by state or condition
- Descriptive context names for clarity
- Nested contexts for complex scenarios
- Shared setup within contexts

**Common Patterns:**
```ruby
describe User do
  context 'when active' do
    # Tests for active users
  end

  context 'when inactive' do
    # Tests for inactive users
  end
end
```

### `described_class_spec.rb`
Demonstrates the `described_class` helper for referencing the class being tested.

**Key Features:**
- `described_class` - References the class in the outermost `describe`
- Useful for refactoring and maintainability
- Works with class names that might change
- Cleaner than hardcoding class names

**Example:**
```ruby
RSpec.describe User do
  it 'creates an instance' do
    user = described_class.new  # Same as User.new
    expect(user).to be_a(described_class)
  end
end
```

### `override_let_spec.rb`
Shows how to override `let` declarations in nested contexts for different test scenarios.

**Key Features:**
- Lazy evaluation of `let` declarations
- Overriding `let` in nested contexts
- Scope and inheritance of `let` variables
- `let!` for eager evaluation when needed

**Example Patterns:**
```ruby
describe Calculator do
  let(:value) { 10 }

  context 'with positive numbers' do
    it 'works with default value' do
      expect(value).to eq(10)
    end
  end

  context 'with negative numbers' do
    let(:value) { -5 }  # Override for this context
    
    it 'uses overridden value' do
      expect(value).to eq(-5)
    end
  end
end
```

## Key Learning Points

### Context Organization
1. **Use descriptive names** - Contexts should clearly describe the scenario
2. **Group related tests** - Similar conditions should be in the same context
3. **Nest appropriately** - Don't over-nest, but use hierarchy for clarity

### Subject Management
1. **Implicit subjects** - Automatically created when describing a class
2. **Explicit subjects** - Define when you need specific setup
3. **Subject isolation** - Each example gets a fresh subject instance

### Let Declarations
1. **Lazy evaluation** - `let` only executes when referenced
2. **Memoization** - Same value returned within an example
3. **Inheritance** - Child contexts inherit parent `let` declarations
4. **Override pattern** - Redefine `let` in nested contexts for variations

## Running Tests

```bash
# Run all context tests
rspec contexts/

# Run specific context examples
rspec contexts/array_spec.rb
rspec contexts/context_spec.rb
rspec contexts/described_class_spec.rb
rspec contexts/override_let_spec.rb
```

## Best Practices

### Context Naming
```ruby
# Good - describes the condition
context 'when user is logged in'
context 'with valid parameters'
context 'when database is empty'

# Avoid - not descriptive
context 'test case 1'
context 'scenario A'
```

### Subject Usage
```ruby
# Good - clear what's being tested
describe User do
  subject { User.new(email: 'test@example.com') }
end

# Good - using described_class
describe User do
  subject { described_class.new }
end
```

### Let Organization
```ruby
describe OrderProcessor do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:order) { Order.new(user: user, product: product) }
  
  context 'with premium user' do
    let(:user) { create(:user, premium: true) }
    # order will now use the premium user
  end
end
```

## Common Patterns

### State-based Contexts
```ruby
describe BankAccount do
  context 'when account has sufficient funds' do
    subject { BankAccount.new(balance: 100) }
    
    it 'allows withdrawal' do
      expect { subject.withdraw(50) }.to change(subject, :balance).by(-50)
    end
  end

  context 'when account has insufficient funds' do
    subject { BankAccount.new(balance: 10) }
    
    it 'raises an error' do
      expect { subject.withdraw(50) }.to raise_error(InsufficientFunds)
    end
  end
end
```

### Input Validation Contexts
```ruby
describe EmailValidator do
  context 'with valid email' do
    let(:email) { 'user@example.com' }
    it { is_expected.to be_valid }
  end

  context 'with invalid email' do
    let(:email) { 'invalid-email' }
    it { is_expected.not_to be_valid }
  end
end
```

## Integration with Other RSpec Features

- **Hooks** - Use `before` and `after` hooks within contexts
- **Shared examples** - Include shared behavior in specific contexts
- **Custom matchers** - Create context-specific matchers
- **Metadata** - Tag contexts for selective test running

## Next Steps

- Explore nested contexts for complex scenarios
- Combine contexts with shared examples for powerful patterns
- Learn about RSpec metadata for context tagging
- Practice organizing large test suites with clear context hierarchies
