# Subject in RSpec

This folder explores RSpec's `subject` feature, which provides a convenient way to define the primary object under test and create more concise, readable tests.

## Overview

The `subject` is RSpec's way of defining "the thing you're testing." It provides:
- A conventional way to define the main object under test
- Shortcuts for common testing patterns
- More readable and DRY test code

## Files and Concepts

### `explicit_subject_spec.rb`
Demonstrates explicitly defining `subject` using the `subject` helper.

**Key Features:**
- `subject { ... }` - Explicitly define what you're testing
- `subject(:name) { ... }` - Named subjects for clarity
- Multiple subjects in different contexts

**Example:**
```ruby
describe Array do
  subject { [1, 2, 3] }
  
  it { is_expected.to include(2) }
  it { expect(subject.length).to eq(3) }
end
```

### `implicit_subject_spec.rb`
Shows how RSpec automatically creates a subject when you describe a class.

**Key Features:**
- Automatic subject creation for class descriptions
- `described_class` - Reference to the class being described
- When implicit subjects are useful vs. explicit

**Example:**
```ruby
describe Array do
  # subject is automatically Array.new
  it { is_expected.to be_empty }
end

describe User do
  # subject is automatically User.new
  it { is_expected.to respond_to(:name) }
end
```

## Key Concepts

### `is_expected` vs `expect(subject)`

Two ways to test the subject:

```ruby
# These are equivalent:
it { is_expected.to be_empty }
it { expect(subject).to be_empty }

# is_expected is more concise for simple assertions
# expect(subject) is better for complex expressions
```

### Subject Patterns

1. **Implicit Subject** - Auto-created from class name
   ```ruby
   describe User do
     # subject is User.new
   end
   ```

2. **Explicit Subject** - Explicitly defined
   ```ruby
   describe User do
     subject { User.new(name: 'John') }
   end
   ```

3. **Named Subject** - Explicit with a name
   ```ruby
   describe User do
     subject(:user) { User.new(name: 'John') }
     
     it { expect(user.name).to eq('John') }
   end
   ```

## When to Use Each Approach

### Use Implicit Subject When:
- Testing a class with a simple constructor
- The default initialization is sufficient
- You want minimal setup

### Use Explicit Subject When:
- You need specific initialization parameters
- Testing a complex object setup
- The implicit subject isn't what you want to test

### Use Named Subject When:
- You reference the subject multiple times
- You want more descriptive test code
- Working with complex objects

## Running Tests

```bash
# Run all subject tests
rspec subject/

# Run specific subject examples
rspec subject/explicit_subject_spec.rb
rspec subject/implicit_subject_spec.rb
```

## Best Practices

### 1. Keep Subject Simple
```ruby
# Good
subject { User.new(name: 'John') }

# Avoid complex logic in subject
subject do
  user = User.new
  user.assign_role(:admin)
  user.activate!
  user
end
```

### 2. Use Descriptive Names
```ruby
# Good
subject(:valid_user) { User.new(email: 'valid@example.com') }

# Better than
subject { User.new(email: 'valid@example.com') }
```

### 3. Combine with Let
```ruby
describe User do
  let(:email) { 'user@example.com' }
  subject { User.new(email: email) }
  
  # Tests can modify let variables for different scenarios
end
```

## Common Patterns

### Testing Different States
```ruby
describe User do
  context 'when active' do
    subject { User.new(status: 'active') }
    it { is_expected.to be_active }
  end
  
  context 'when inactive' do
    subject { User.new(status: 'inactive') }
    it { is_expected.not_to be_active }
  end
end
```

### One-liner Tests
```ruby
describe Calculator do
  subject { Calculator.new }
  
  it { is_expected.to respond_to(:add) }
  it { is_expected.to respond_to(:subtract) }
  it { is_expected.to respond_to(:multiply) }
end
```

### Complex Object Testing
```ruby
describe 'shopping cart' do
  subject(:cart) { ShoppingCart.new }
  
  before do
    cart.add_item(product, quantity: 2)
  end
  
  it { expect(cart.total).to eq(expected_total) }
  it { expect(cart.item_count).to eq(2) }
end
```

## Benefits

1. **Readability** - Clear what's being tested
2. **Conciseness** - One-liner tests with `is_expected`
3. **Convention** - Standard RSpec pattern
4. **DRY** - Avoid repeating object creation

## Common Mistakes

1. **Complex subject logic** - Keep it simple
2. **Mutable subjects** - Can cause test dependencies
3. **Overusing implicit subjects** - Sometimes explicit is clearer
4. **Not using named subjects** - When referenced multiple times

## Next Steps

- Combine subjects with `let` for more flexible test data
- Use subjects with shared examples for consistent testing
- Explore `subject!` for eager evaluation
- Learn about subject inheritance in nested contexts
