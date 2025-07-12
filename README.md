# RubyDubyDoo - RSpec Learning Project

A comprehensive collection of RSpec examples, patterns, and best practices for mastering Ruby testing. This project provides hands-on examples covering everything from basic matchers to advanced mocking patterns.

## 🎯 Project Overview

This repository serves as a complete learning resource for RSpec, Ruby's premier testing framework. Whether you're new to testing or looking to master advanced RSpec features, you'll find practical examples and clear explanations for every concept.

**What you'll learn:**
- RSpec fundamentals and testing philosophy
- All major matcher types and their use cases
- Mocking, stubbing, and test double patterns
- Test organization with contexts and hooks
- Object-oriented testing strategies
- Shared functionality and DRY testing principles

## 📚 Table of Contents

### Core RSpec Features

#### 🔍 [Matchers](./matchers/)
The building blocks of RSpec assertions - learn to express expectations clearly and effectively.

- **Basic Matchers**: `equality_matchers_spec.rb`, `comparison_matchers_spec.rb`, `be_matcher_spec.rb`
- **Collection Testing**: `include_matcher_spec.rb`, `contain_exactly_spec.rb`, `all_matcher_spec.rb`
- **Type & Structure**: `predicate_matchers_spec.rb`, `respond_to_matcher_spec.rb`, `have_attributes_matcher_spec.rb`
- **Advanced**: `change_matcher_spec.rb`, `raise_error_matcher.rb`, `satisfy_matcher.rb`
- **Composition**: `compound_expectations_spec.rb`, `not_to_spec.rb`

#### 🎭 [Mocking & Test Doubles](./mocking/)
Master isolation testing with comprehensive mocking and stubbing examples.

- **Fundamentals**: `double_spec.rb`, `allow_spec.rb`
- **Advanced Doubles**: `instance_doubles_spec.rb`, `class_double_spec.rb`
- **Verification**: `spies_spec.rb`, `matching_arguments_spec.rb`
- **Real-world Examples**: `movie_spec.rb`

#### 🏗️ [Classes & Objects](./classes/)
Learn object-oriented testing with real Ruby classes and inheritance patterns.

- **Core Classes**: `vehicle.rb`, `garage.rb`, `card_game.rb`
- **Testing Patterns**: `card_spec.rb`
- **Concepts**: Inheritance, polymorphism, object collaboration

### Test Organization

#### 📋 [Contexts & Organization](./contexts/)
Structure your tests effectively with contexts, subjects, and let declarations.

- **Context Usage**: `context_spec.rb`, `array_spec.rb`
- **Class Testing**: `described_class_spec.rb`
- **Variable Management**: `override_let_spec.rb`

#### 🪝 [Hooks & Lifecycle](./hooks/)
Manage test setup and teardown with RSpec's powerful hook system.

- **Basic Hooks**: `before_and_after_spec.rb`, `single_context_hooks_spec.rb`
- **Complex Scenarios**: `multi_context_hooks_spec.rb`, `nested_hooks_spec.rb`

#### 🎯 [Subject Management](./subject/)
Master RSpec's subject feature for cleaner, more expressive tests.

- **Explicit Subjects**: `explicit_subject_spec.rb`
- **Implicit Subjects**: `implicit_subject_spec.rb`

#### 🔄 [Shared Functionality](./shared_functionality/)
Create DRY test suites with shared examples and contexts.

- **Shared Examples**: `shared_examples_spec.rb`
- **Shared Contexts**: `shared_context_spec.rb`

#### 📝 [Assignments](./assignments/)
Practice exercises to reinforce your learning.

- **Predicates & Collections**: `assignment_predicates_all_be_spec.rb`

## 🚀 Getting Started

### Prerequisites

- Ruby 3.0+ (recommended: 3.4.4)
- RSpec gem

### Installation

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd rubydubydoo
   ```

2. **Install dependencies:**
   ```bash
   bundle install
   ```

3. **Run all tests:**
   ```bash
   rspec
   ```

### Running Tests

```bash
# Run all tests
rspec

# Run tests by folder
rspec matchers/
rspec mocking/
rspec classes/

# Run specific test files
rspec matchers/equality_matchers_spec.rb
rspec mocking/spies_spec.rb

# Run with documentation format
rspec --format documentation

# Run and see test coverage
rspec --format html --out rspec_results.html
```

## 📖 Learning Path

### Beginner Track
1. Start with **[Matchers](./matchers/)** - Learn basic assertions
2. Explore **[Subject](./subject/)** - Understand what you're testing
3. Practice with **[Contexts](./contexts/)** - Organize your tests
4. Try **[Assignments](./assignments/)** - Reinforce your learning

### Intermediate Track
1. **[Hooks](./hooks/)** - Master test lifecycle management
2. **[Classes](./classes/)** - Object-oriented testing patterns
3. **[Shared Functionality](./shared_functionality/)** - DRY testing principles

### Advanced Track
1. **[Mocking](./mocking/)** - Isolation testing and test doubles
2. Advanced matcher patterns and custom matchers
3. Complex test organization and architecture

## 🛠️ Development Setup

### Code Quality

This project uses RuboCop for code formatting and style checking:

```bash
# Check code style
bundle exec rubocop

# Auto-fix issues
bundle exec rubocop -A
```

### VS Code Integration

For VS Code users, the project includes configuration for:
- RuboCop formatting on save
- Ruby LSP integration
- RSpec test runner integration

## 🤝 Contributing

This is a learning project, but contributions are welcome! If you find errors, have suggestions for improvements, or want to add new examples:

1. Fork the repository
2. Create a feature branch
3. Add your examples with accompanying documentation
4. Ensure all tests pass
5. Submit a pull request

## 📚 Additional Resources

- [RSpec Documentation](https://rspec.info/)
- [Better Specs](https://www.betterspecs.org/)
- [Effective Testing with RSpec](https://pragprog.com/titles/rspec3/effective-testing-with-rspec-3/)
- [Ruby Testing Handbook](https://testinghandbook.com/)

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

**Happy Testing! 🧪✨**

*"The best code is well-tested code. The best tests are clear, concise, and comprehensive."*