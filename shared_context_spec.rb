RSpec.shared_context 'Common Context' do
  before do 
    @main = []
    @dessert = []
    @drinks = []
  end

  def cook(food)
    @main << food
    puts "Cooking #{food}..."
  end
  def prepare_drink(drink)
    @drinks << drink
    puts "Preparing #{drink}..."
  end
  def creating_dessert(dessert)
    @dessert << dessert
    puts "Creating dessert: #{dessert}..."
  end

  let (:dinner) do 
    {
      main: @main,
      dessert: @dessert,
      drinks: @drinks
    }
  end
end 

RSpec.describe 'Italian Dinner' do
  include_context 'Common Context'
  
  before do 
    cook('Pasta')
    prepare_drink('Wine')
    creating_dessert('Tiramisu')
  end

  it 'has a main course' do
    expect(dinner[:main]).to include('Pasta')
  end

  it 'has a drink' do
    expect(dinner[:drinks]).to include('Wine')
  end

  it 'has a dessert' do
    expect(dinner[:dessert]).to include('Tiramisu')
  end
end

RSpec.describe 'Mexican Dinner' do
  include_context 'Common Context'

  before do
    cook('Tacos')
    prepare_drink('Margarita')
    creating_dessert('Churros')
  end

  it 'has a main course' do
    expect(dinner[:main]).to include('Tacos')
  end

  it 'has a drink' do
    expect(dinner[:drinks]).to include('Margarita')
  end

  it 'has a dessert' do
    expect(dinner[:dessert]).to include('Churros')
  end
end