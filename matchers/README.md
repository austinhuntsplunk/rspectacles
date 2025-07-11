# RSpec Matchers

This folder contains examples of various RSpec matchers - the building blocks for making assertions in your tests. Matchers provide a fluent, readable way to express expectations about your code's behavior.

## Overview

Matchers are the heart of RSpec's assertion system. They follow the pattern:
```ruby
expect(actual).to matcher(expected)
expect(actual).not_to matcher(expected)
```

## Files and Concepts

### Basic Matchers
- **`equality_matchers_spec.rb`** - Different ways to test equality (`eq`, `eql`, `equal`, `be`)
- **`comparison_matchers_spec.rb`** - Numerical comparisons (`be >`, `be <`, `be_between`)
- **`be_matcher_spec.rb`** - Identity and truthiness testing (`be`, `be_truthy`, `be_falsy`)

### Type and Structure Matchers
- **`predicate_matchers_spec.rb`** - Testing boolean methods (`be_zero`, `be_even`, `be_odd`)
- **`respond_to_matcher_spec.rb`** - Testing if objects respond to methods (polymorphism)
- **`have_attributes_matcher_spec.rb`** - Testing object attributes in bulk

### Collection Matchers
- **`include_matcher_spec.rb`** - Testing collection membership
- **`contain_exactly_spec.rb`** - Testing exact collection contents (order independent)
- **`all_matcher_spec.rb`** - Testing that all elements match a condition
- **`start_with_and_end_with_matchers_spec.rb`** - Testing string/array boundaries

### Custom and Advanced Matchers
- **`satisfy_matcher.rb`** - Custom conditions with blocks
- **`change_matcher_spec.rb`** - Testing state changes over time
- **`raise_error_matcher.rb`** - Testing exception handling
- **`not_to_spec.rb`** - Negating expectations

### Compound Matchers
- **`compound_expectations_spec.rb`** - Combining multiple matchers with `and`/`or`

## Key Learning Points

1. **Readability**: Matchers make tests read like natural language
2. **Specificity**: Choose the most specific matcher for better error messages
3. **Composability**: Combine matchers using `and` and `or`
4. **Custom Matchers**: Create your own when built-ins aren't sufficient

## Running Tests

```bash
# Run all matcher tests
rspec matchers/

# Run specific matcher tests
rspec matchers/equality_matchers_spec.rb
rspec matchers/predicate_matchers_spec.rb
```

## Common Patterns

### Testing Collections
```ruby
expect([1, 2, 3]).to include(2)
expect([1, 2, 3]).to contain_exactly(3, 1, 2)
expect([2, 4, 6]).to all(be_even)
```

### Testing State Changes
```ruby
expect { counter.increment }.to change(counter, :value).by(1)
expect { create_user }.to change(User, :count).from(0).to(1)
```

### Custom Conditions
```ruby
expect(user).to satisfy { |u| u.age >= 18 }
```

## Next Steps

After mastering these matchers, explore:
- Custom matcher creation with `RSpec::Matchers.define`
- Compound expectations for complex assertions
- Integration with shared examples and contexts
