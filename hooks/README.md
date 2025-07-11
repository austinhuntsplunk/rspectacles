# RSpec Hooks

This folder demonstrates RSpec's hook system for setting up and tearing down test environments. Hooks allow you to run code before and after tests, helping manage test state and ensure clean, isolated testing.

## Overview

Hooks are methods that run at specific points in the test lifecycle:
- **`before`** - Run setup code before tests
- **`after`** - Run cleanup code after tests  
- **`around`** - Wrap tests with setup and teardown

## Files and Concepts

### `before_and_after_spec.rb`
Basic introduction to `before` and `after` hooks at different scopes.

**Key Features:**
- `before(:example)` - Run before each test (most common)
- `before(:context)` - Run once before all tests in a group
- `after(:example)` - Run after each test
- `after(:context)` - Run once after all tests in a group

### `single_context_hooks_spec.rb`
Demonstrates hooks within a single `describe` or `context` block.

**Concepts:**
- Hook execution order
- Instance variable sharing
- Setup and teardown patterns

### `multi_context_hooks_spec.rb`
Shows how hooks behave across multiple `context` blocks within the same `describe`.

**Key Learning:**
- Hook inheritance from parent contexts
- Context-specific setup
- Combining global and local hooks

### `nested_hooks_spec.rb`
Explores hook behavior in nested `describe` and `context` blocks.

**Advanced Concepts:**
- Hook execution order in nested structures
- Hook inheritance hierarchy
- Overriding parent hooks

## Hook Execution Order

Understanding when hooks run is crucial:

```ruby
describe 'Example' do
  before(:context) { puts "1. Before context (once)" }
  before(:example) { puts "2. Before each example" }
  after(:example) { puts "3. After each example" }
  after(:context) { puts "4. After context (once)" }
  
  it 'test 1' { puts "Running test 1" }
  it 'test 2' { puts "Running test 2" }
end
```

**Output:**
```
1. Before context (once)
2. Before each example
Running test 1
3. After each example
2. Before each example  
Running test 2
3. After each example
4. After context (once)
```

## Key Learning Points

### Hook Scopes

1. **`:example` scope** (default)
   - Runs before/after each individual test
   - Most commonly used
   - Good for test-specific setup

2. **`:context` scope**
   - Runs once before/after entire test group
   - Faster but can create test dependencies
   - Good for expensive setup (database, external services)

### Best Practices

1. **Prefer `:example` scope** - Keeps tests isolated
2. **Use instance variables** - Share data between hooks and tests
3. **Keep hooks simple** - Complex logic belongs in helper methods
4. **Clean up after yourself** - Use `after` hooks to reset state

## Running Tests

```bash
# Run all hook tests
rspec hooks/

# Run specific hook examples
rspec hooks/before_and_after_spec.rb
rspec hooks/nested_hooks_spec.rb
```

## Common Patterns

### Database Setup
```ruby
describe UserService do
  before(:context) { DatabaseCleaner.start }
  after(:context) { DatabaseCleaner.clean }
  
  before(:example) { @user = create(:user) }
  after(:example) { @user.destroy }
end
```

### API Testing
```ruby
describe 'API calls' do
  before { stub_external_api }
  after { reset_api_stubs }
  
  # tests here
end
```

### File System Operations
```ruby
describe FileProcessor do
  before { create_temp_directory }
  after { cleanup_temp_directory }
  
  # file processing tests
end
```

## Common Pitfalls

1. **Shared state between tests** - Can cause test dependencies
2. **Expensive context-level hooks** - May slow down test suite
3. **Forgetting cleanup** - Can cause test pollution
4. **Complex hook logic** - Makes tests harder to understand

## Hook Alternatives

Sometimes better alternatives exist:
- **`let` and `let!`** - Lazy-loaded test data
- **Factory methods** - Create test objects on demand
- **Helper methods** - Explicit setup in tests

## Next Steps

- Combine hooks with `let` for powerful test setup
- Use hooks with shared contexts for reusable setup
- Learn about `around` hooks for more complex scenarios
- Explore RSpec's metadata system for conditional hooks
