

class Player
  attr_reader :name, :hand

  def initialize(name)
    @name = name
    @hand = []
  end

  def hand=(cards)
    @hand = cards
    puts "#{@name} has been dealt #{cards.size} cards."
  end

  def play_card(card)
    puts "#{@name} plays #{card}"
    card # Return the card played so it can be placed back into deck
  end
end

class Deck
  attr_reader :cards

  def initialize
    @cards = []
  end

  def shuffle
    @cards.shuffle!
    puts 'Deck shuffled.'
  end

  def self.build
    @cards = %w[Hearts Diamonds Clubs Spades].flat_map do |suit|
      %w[Ace King Queen Jack 10 9 8 7 6 5 4 3 2].map do |rank|
        "#{rank} of #{suit}"
      end
    end
    puts "Deck initialized with #{@cards.size} cards."
    @cards
  end
end

# CardGame class that uses the Deck class to build a deck of cards
# and allows players to play the game with methods like deal, shuffle, and play.

class CardGame
  attr_reader :deck, :players, :deck_per_player

  def initialize
    @deck = Deck.build
    @players = []
  end

  def add_player(player)
    @players << player
    puts "#{player.name} has joined the game."
    @cards_per_player = @deck.size / @players.size
  end

  def play
    # Game logic goes here
    puts "Playing with #{@deck.size} cards."
  end

  def shuffle_deck
    @deck.shuffle!
  end

  def deal(number_of_cards)
    # deal to each player
    @players.each do |player|
      player.hand = @deck.pop(number_of_cards)
      puts "#{player.name} has been dealt #{number_of_cards} cards."
    end
  end

  def remaining_cards
    @deck.size
  end
end
