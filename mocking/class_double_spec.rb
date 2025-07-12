

# Class doubles allow you to mock a class (not an instance of a class) and specify the behavior of its methods.
# This is useful when you want to test interactions with a class without needing to instantiate it.
require_relative '../classes/card_game'

# When to use class doubles: you're testing a class that uses another class's CLASS methods.
# When to use instance doubles: you're testing a class that uses another class's INSTANCE methods.

RSpec.describe 'Class Double' do
  it 'can only impelement class methods that are defined on a class' do
    deck_class_double = class_double(
      Deck, build: ['Ace of Spades', 'King of Hearts', '10 of Diamonds', '2 of Clubs', '3 of Spades']
    ) # good

    expect do
      deck_class_double = class_double(
        Deck,
        build: ['Ace of Spades', 'King of Hearts', '10 of Diamonds', '2 of Clubs', '3 of Spades'],
        shuffle: 'Deck shuffled!'
      ) # bad, because shuffle is not a CLASS METHOD, it is an INSTANCE METHOD
    end.to raise_error(RSpec::Mocks::MockExpectationError,
                       /the Deck class does not implement the class method: shuffle/)
  end

  it 'can be used to mock a class with class methods that will EVENTUALLY exist even if they don\'t already' do
    # Use a string to refer to class by name since it does exist yet
    my_fake_class_double = class_double('MyFakeClass', my_class_method: 'This is a fake class method!')
    expect(my_fake_class_double.my_class_method).to eq('This is a fake class method!')

    # You can also use a block to define the behavior of the class method
    allow(my_fake_class_double).to receive(:another_class_method) { 'This is another fake class method!' }
    expect(my_fake_class_double.another_class_method).to eq('This is another fake class method!')
  end

  it 'demonstrates how as_stubbed_const works with class doubles' do
    # This is a way to stub a class constant so that it can be used in tests
    # without needing the actual class to be defined.

    # Note that if the class IS already defined, the .as_stubbed_const will replace the class with the double
    # BUT it still limits the methods to those defined on the class.
    expect do
      class_double(
        'Deck', # Use a string to refer to the class by name particularly if it does not exist yet
        build: ['Ace of Spades', 'King of Hearts', '10 of Diamonds', '2 of Clubs', '3 of Spades'],
        shuffle: 'Deck shuffled!'
      ).as_stubbed_const
    end.to raise_error(RSpec::Mocks::MockExpectationError,
                       /the Deck class does not implement the class method: shuffle/)

    # If you want to stub a class method that does not exist yet, you can use the `as_stubbed_const` method
    # to create a class double that will allow you to define the behavior of the class methods.
    fake_deck_class = class_double(
      'Deck', # Use a string to refer to the class by name particularly if it does not exist yet
      build: ['Ace of Spades', 'King of Hearts', '10 of Diamonds', '2 of Clubs', '3 of Spades']
    ).as_stubbed_const

    expect(fake_deck_class.build).to eq(['Ace of Spades', 'King of Hearts', '10 of Diamonds', '2 of Clubs',
                                         '3 of Spades'])
  end

  it 'tests a card game with a Deck class double with stubbed const' do
    deck_klass = class_double(
      Deck,
      build: ['Ace of Spades', 'King of Hearts', '10 of Diamonds', '2 of Clubs', '3 of Spades']
    ).as_stubbed_const # says to use this class double instead of the actual Deck class when Deck is referenced by test subjects

    expected_build = ['Ace of Spades', 'King of Hearts', '10 of Diamonds', '2 of Clubs', '3 of Spades']
    expect(deck_klass).to receive(:build).and_return(expected_build)
    card_game = CardGame.new
    expect(card_game.deck).to eq(expected_build)
  end
end
