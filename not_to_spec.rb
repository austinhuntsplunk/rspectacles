RSpec.describe 'Not to spec' do 
  subject(:mynumber) { 10 }
  subject(:mystring) { 'Hello' }
  subject(:myhash) { { key: 'value' } }

  context 'mynumber 10' do
    it 'is not equal to 5' do
      expect(mynumber).not_to eq(5)
    end
  end 

  context 'mystring Hello' do
    it 'is not equal to Goodbye' do
      expect(mystring).not_to eq('Goodbye')
    end
  end

  context 'myhash { key: "value" }' do
    it 'is not equal to { key: "other_value" }' do
      expect(myhash).not_to eq({ key: 'other_value' })
    end
    it 'does not have key scooby' do 
      expect(myhash).not_to have_key(:scooby)
    end
  end




end