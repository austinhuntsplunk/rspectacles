

class ProfessionalWrestler
  attr_reader :name, :finishing_move

  def initialize(name, finishing_move)
    @name = name
    @finishing_move = finishing_move
  end
end

RSpec.describe 'have_attributes matcher' do
  let(:wrestler) { ProfessionalWrestler.new('Stone Cold Steve Austin', 'Stone Cold Stunner') }

  it 'checks if an object has specific attributes' do
    expect(wrestler).to have_attributes(name: 'Stone Cold Steve Austin', finishing_move: 'Stone Cold Stunner')
  end

  it 'checks if an object does not have specific attributes' do
    expect(wrestler).not_to have_attributes(name: 'The Rock', finishing_move: 'Rock Bottom')
  end

  # could also use it as the subject
  describe ProfessionalWrestler.new('The Undertaker', 'Tombstone Piledriver') do
    it 'has the correct name and finishing move' do
      expect(subject).to have_attributes(name: 'The Undertaker', finishing_move: 'Tombstone Piledriver')
    end

    it 'does not have the wrong name and finishing move' do
      expect(subject).not_to have_attributes(name: 'John Cena', finishing_move: 'Attitude Adjustment')
    end

    # one liner syntax
    it { is_expected.to have_attributes(name: 'The Undertaker', finishing_move: 'Tombstone Piledriver') }
  end
end
