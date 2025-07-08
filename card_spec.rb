class Card 
    attr_reader :rank, :suit, :type 
    def initialize(rank, suit)
      @rank = rank 
      @suit = suit 
      @type = "#{rank} of #{suit}"
    end

    def rank=(new_rank)
      @rank = new_rank
      @type = "#{rank} of #{suit}"
    end

    def suit=(new_suit)
      @suit = new_suit
      @type = "#{rank} of #{suit}"
    end

    def to_s
      "#{rank} of #{suit}"
    end
end
RSpec.describe 'Card' do 
    let(:card) { Card.new('Ace', 'Spades') }
    it 'has a rank' do 
      expect(card.rank).to eq('Ace')
      card.rank = 'Queen'
      expect(card.rank).to eq('Queen')
    end

    it 'has a suit' do 
      expect(card.suit).to eq('Spades')
      card.suit = 'Hearts'
      expect(card.suit).to eq('Hearts')
    end

    it 'has a type' do 
      expect(card.type).to eq('Ace of Spades')
      card.rank = 'Queen'
      card.suit = 'Hearts'
      expect(card.type).to eq('Queen of Hearts')
    end

    it 'can be converted to a string' do
      expect(card.to_s).to eq('Ace of Spades')
      card.rank = 'Queen'
      card.suit = 'Hearts'
      expect(card.to_s).to eq('Queen of Hearts')
    end

    it 'testing a custom error message' do 
        card.suit = 'Nonsense'
        comparison = 'Spades'
        expect(card.suit).to eq(comparison), "Expected suit to be #{comparison}, but it was #{card.suit}"
    end
end 