# RSpec Assignments

This folder contains practice assignments and exercises for learning RSpec fundamentals through hands-on coding challenges.

## Overview

These assignments provide structured practice with RSpec concepts, allowing you to test your understanding and build proficiency with:
- Predicate matchers and boolean testing
- Collection testing with `all` matcher
- Truthiness and falsiness evaluation in Ruby
- Practical application of RSpec patterns

## Files and Concepts

### `assignment_predicates_all_be_spec.rb`
A comprehensive assignment covering predicates, `all` matcher, and `be` matchers.

**Learning Objectives:**
- **Predicate matchers** - Testing boolean methods like `even?`, `empty?`
- **All matcher** - Validating that all elements in a collection meet criteria
- **Be matchers** - Testing identity, truthiness, and comparison operations
- **Ruby truthiness** - Understanding what values are truthy/falsy in Ruby

**Key Concepts Practiced:**
```ruby
# Testing collection properties
expect([10, 20, 30]).to all(be_even)

# Testing range comparisons
expect([0, 1, 2]).to all(be >= 0)

# Testing truthiness (remember: only nil and false are falsy in Ruby!)
expect("hello").to be_truthy  # strings are truthy
expect(0).to be_truthy        # zero is truthy in Ruby
expect([]).to be_truthy       # empty arrays are truthy
expect(false).to be_falsy     # only false and nil are falsy
expect(nil).to be_falsy
```

**Ruby Truthiness Rules:**
- **Falsy values**: Only `nil` and `false`
- **Truthy values**: Everything else, including:
  - `0` (unlike JavaScript/C)
  - Empty strings `""`
  - Empty arrays `[]`
  - Empty hashes `{}`

## Running Tests

```bash
# Run assignment tests
rspec assignments/

# Run specific assignment
rspec assignments/assignment_predicates_all_be_spec.rb
```

## Next Steps

After completing these assignments:
- Explore advanced matcher combinations
- Practice with custom matchers
- Apply concepts to real-world testing scenarios
- Review the patterns learned in other folders
