class ProgrammingLanguage 
  attr_reader :name 
  def initialize(name = 'Unknown')
    @name = name 
  end

  def name=(new_name)
    @name = new_name
  end

  def to_s
    "Programming Language: #{@name}"
  end
end

RSpec.describe ProgrammingLanguage do 
  let(:language) { ProgrammingLanguage.new('Python') }
  
  it 'stores the name of the programming language' do
    expect(language.name).to eq('Python') 
  end

  context 'with no argument' do
    let(:language) { ProgrammingLanguage.new }
    before(:context) do 
      puts 'Overriding language in this scope with no name argument; otherwise, higher context :language will be used'
    end 
     it 'should default to "Unknown"' do
      expect(language.name).to eq('Unknown')
    end
  end

end