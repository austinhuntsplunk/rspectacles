

# Any time you see a question mark in a method name, it indicates that the method returns a boolean value.
RSpec.describe 'Predicate matchers' do
  # There is a predicate matcher on every number called .zero?
  it 'checks if a number is zero' do
    expect(0.zero?).to be true
    expect(1.zero?).to be false
    expect(0).to be_zero # This will pass because 0 is zero
    expect(1).not_to be_zero # This will pass because 1 is not zero
  end

  # There is a predicate matcher on every number called .even?
  it 'checks if a number is even' do
    expect(2.even?).to be true
    expect(3.even?).to be false
    expect(2).to be_even # This will pass because 2 is even
    expect(3).not_to be_even # This will pass because 3 is not even
  end

  # There is a predicate matcher on every number called .odd?
  it 'checks if a number is odd' do
    expect(3.odd?).to be true
    expect(4.odd?).to be false
    expect(3).to be_odd
    expect(3).not_to be_even # This will pass because 3 is odd
  end

  describe 'using predicate to check calculation results' do
    it 'can be tested with ruby methods' do
      result = 16 / 2
      expect(result).to be_even # This will pass because 16 / 2 = 8, which is even
      expect(result).not_to be_odd # This will pass because 8 is not odd
    end

    it 'can be tested with RSpec predicate matchers' do
      expect(16 / 2).to be_even # This will pass because 16 / 2 = 8, which is even
      expect(16 / 2).not_to be_odd # This will pass because 8 is not odd
    end
  end

  # There is a predicate matcher on every string called .empty?
  it 'checks if a string is empty' do
    expect(''.empty?).to be true
    expect('Hello'.empty?).to be false
    # same as a length check
    expect('Hello'.length).to be_positive

    expect('Hello').not_to be_empty
    # be_present checks if the object is not nil or empty
    #
    RSpec::Matchers.define :be_present do
      match do |actual|
        !actual.nil? && !actual.empty?
      end

      failure_message do |actual|
        "expected #{actual} to be present (not nil or empty)"
      end

      failure_message_when_negated do |actual|
        "expected #{actual} not to be present (not nil or empty)"
      end
    end
    expect('Hello').to be_present
  end

  describe 0 do
    it { is_expected.to be_zero }
  end
end
