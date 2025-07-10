RSpec.describe 'raise_error matcher' do 
  describe 'raising errors' do 
    it 'raises a specific error' do 
      expect { raise 'An error occurred' }.to raise_error(RuntimeError, 'An error occurred')
    end

    it 'raises an error with a custom message' do 
      expect { raise 'Custom error message' }.to raise_error(RuntimeError, 'Custom error message')
    end

    it 'raises an undefined class error (NameError)' do 
      expect { Jeep.new }.to raise_error(NameError, /uninitialized constant Jeep/)
    end

    it 'does not raise an error when no error is expected' do 
      expect { 1 + 1 }.not_to raise_error
    end

    it 'raises a specific type of error' do 
      expect { raise ArgumentError, 'Invalid argument' }.to raise_error(ArgumentError)
    end

    it 'raises division by zero error' do
      expect { 1 / 0 }.to raise_error(ZeroDivisionError)
    end 

    it 'raises a custom error' do
      class CustomError < StandardError; end
      expect { raise CustomError, 'This is a custom error' }.to raise_error(CustomError, 'This is a custom error')
    end
 
  end
end