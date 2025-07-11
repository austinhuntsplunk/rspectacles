# Shared Functionality

This folder demonstrates RSpec's powerful features for sharing code across multiple test contexts, promoting DRY (Don't Repeat Yourself) principles in your test suite.

## Overview

Shared functionality in RSpec allows you to:
- **Shared Examples**: Reuse test behavior across different contexts
- **Shared Context**: Share setup code, helper methods, and variables

## Files and Concepts

### `shared_examples_spec.rb`
Demonstrates how to create and use shared example groups that can be included in multiple test contexts.

**Key Features:**
- `RSpec.shared_examples` - Define reusable test behaviors
- `it_behaves_like` - Include shared examples in test contexts
- `include_examples` - Alternative way to include shared examples

**Example Pattern:**
```ruby
RSpec.shared_examples 'a collection' do
  it 'has a length' do
    expect(subject.length).to be > 0
  end
end

RSpec.describe Array do
  subject { [1, 2, 3] }
  it_behaves_like 'a collection'
end
```

### `shared_context_spec.rb`
Shows how to share setup code, helper methods, and instance variables across multiple test contexts.

**Key Features:**
- `RSpec.shared_context` - Define reusable setup and helper methods
- `include_context` - Include shared context in test groups
- Shared `before` hooks and helper methods
- Shared `let` declarations

**Example Pattern:**
```ruby
RSpec.shared_context 'database setup' do
  before { setup_database }
  let(:user) { create_user }
  
  def helper_method
    # shared helper
  end
end

RSpec.describe UserService do
  include_context 'database setup'
  # Tests can use shared setup and helpers
end
```

## Key Learning Points

### When to Use Shared Examples
- Testing common behavior across different classes (polymorphism)
- Testing interface compliance
- Reducing duplication in similar test scenarios

### When to Use Shared Context
- Common setup procedures
- Shared helper methods
- Common `let` declarations
- Database or API setup

### Best Practices

1. **Keep shared examples focused** - Test one behavior or interface
2. **Use descriptive names** - Make it clear what behavior is being shared
3. **Document dependencies** - Clearly state what the including context must provide
4. **Avoid over-sharing** - Don't force unrelated tests to share context

## Running Tests

```bash
# Run all shared functionality tests
rspec shared_functionality/

# Run specific tests
rspec shared_functionality/shared_examples_spec.rb
rspec shared_functionality/shared_context_spec.rb
```

## Common Patterns

### Interface Testing
```ruby
RSpec.shared_examples 'a vehicle' do
  it { is_expected.to respond_to(:start_engine) }
  it { is_expected.to respond_to(:stop_engine) }
end

# Used across Car, Truck, Motorcycle specs
```

### Common Setup
```ruby
RSpec.shared_context 'authenticated user' do
  let(:user) { create(:user) }
  before { sign_in(user) }
end

# Included in controller specs that need authentication
```

## Benefits

1. **DRY Principle**: Eliminate test code duplication
2. **Consistency**: Ensure similar behaviors are tested the same way
3. **Maintainability**: Update shared behavior in one place
4. **Documentation**: Shared examples serve as behavior contracts

## Next Steps

- Combine shared functionality with hooks for powerful test organization
- Use shared examples to test polymorphic behavior
- Create shared contexts for complex application setup scenarios
