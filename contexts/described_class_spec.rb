

class King
  # Every king has a name
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

RSpec.describe King do
  # subject { King.new('King Arthur') }
  # let(:louis) { King.new('King Louis') }

  # imagine this class is more complicated, with a lot of data and a lot of tests.
  # We want to test the class without having to refer to it by its name. E.g., maybe we want
  # to change the class name but don't want to change the tests when that happens.

  # Avoid hardcoding the class name in the tests by using described_class

  subject { described_class.new('King Arthur') }
  let(:louis) { described_class.new('King Louis') }
  it 'has a name' do
    expect(subject.name).to eq('King Arthur')
    expect(louis.name).to eq('King Louis')
  end
end
