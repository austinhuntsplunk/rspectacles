

# When to use class doubles: you're testing a class that uses another class's CLASS methods.
# When to use instance doubles: you're testing a class that uses another class's INSTANCE methods.

class Person
  def initialize(name, age)
    @name = name
    @age = age
  end

  def say_hello
    puts "Hello, my name is #{@name}."
  end

  def say_age
    puts "I am #{@age} years old."
  end
end

RSpec.describe Person do
  describe 'regular double' do
    it 'can implement any method' do
      doubleperson = double('Person', say_hello: "hey i'm fake", say_age: "i'm not real i am infinite")
      expect(doubleperson.say_hello).to eq("hey i'm fake")
      expect(doubleperson.say_age).to eq("i'm not real i am infinite")
    end
  end

  describe 'instance double' do
    it 'can only implement methods defined on the class' do
      double_person = instance_double(Person, say_hello: "hey i'm fake", say_age: "i'm not real i am infinite")
      expect(double_person.say_hello).to eq("hey i'm fake")
      expect(double_person.say_age).to eq("i'm not real i am infinite")
    end

    it 'raises an error if a method not defined on the class is called' do
      expect do
        instance_double(Person, say_hello: "hey i'm fake",
                                say_goodbye: 'goodbye, this will fail')
      end.to raise_error(RSpec::Mocks::MockExpectationError,
                         /class does not implement the instance method: say_goodbye/)
    end

    it 'raises an error if you try to modify a method that is defined on the class' do
      expect do
        double_person = instance_double(Person, say_hello: "hey i'm fake",
                                                say_age: "i'm not real i am infinite")
        allow(double_person).to receive(:say_hello).with('unexpected argument').and_return('this will fail')
      end.to raise_error(RSpec::Mocks::MockExpectationError, /Wrong number of arguments. Expected 0, got 1/)
    end
  end
end
