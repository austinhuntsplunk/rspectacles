# Get absolute path to vehicle.rb in ../classes/vehicle.rb
# do not use ../
require_relative File.expand_path('../classes/vehicle.rb', __dir__)


[Truck, Motorcycle, Jeep].each do |vehicle_class|
  RSpec.describe vehicle_class do
    let(:vehicle) { vehicle_class.new(color: 'blue', mileage: 0, make: 'Make', model: 'Model', year: 2020) }
    it 'responds to the repaint method' do
      expect(vehicle).to respond_to(:repaint)
    end

    it 'responds to the drive method' do
      expect(vehicle).to respond_to(:drive)
    end

    it 'responds to the hold_for_n_years method' do 
      expect(vehicle).to respond_to(:hold_for_n_years)
    end

    it 'responds to start_engine method' do
      expect(vehicle).to respond_to(:start_engine)
    end

    it 'responds to stop_engine method' do
        expect(vehicle).to respond_to(:stop_engine)
    end

    it { is_expected.to respond_to(:color) }
    it { is_expected.to respond_to(:mileage) }
    it { is_expected.to respond_to(:make) }
    it { is_expected.to respond_to(:model) }
    it { is_expected.to respond_to(:year) }
    it { is_expected.to respond_to(:age) }  
    it { is_expected.to respond_to(:safe) }
  end
end
