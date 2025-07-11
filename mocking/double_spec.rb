RSpec.describe 'A random double' do 
    it 'only allows defined methods to be called' do 
        rickybobby = double('Ricky Bobby', on_fire: 'Help me Oprah Winfrey!', catch_phrase: 'Shake and Bake!', drive_fast: 'If you ain\'t first, you\'re last!')
        expect(rickybobby.on_fire).to eq('Help me Oprah Winfrey!')
        expect(rickybobby.catch_phrase).to eq('Shake and Bake!')
        expect(rickybobby.drive_fast).to eq('If you ain\'t first, you\'re last!')
        expect { rickybobby.run }.to raise_error(RSpec::Mocks::MockExpectationError, /\:run/)
        expect { rickybobby.fly }.to raise_error(RSpec::Mocks::MockExpectationError, /\:fly/) # fly is not defined on the double
        # Basically define a method that is not defined on the double
        allow(rickybobby).to receive(:run).and_return('Running fast!')
        expect(rickybobby.run).to eq('Running fast!')

        cal_naughton_jr = double('Cal Naughton Jr.')
        allow(cal_naughton_jr).to receive_messages(magic_idea: 'Bunny rabbits!', steal_rickys_wife: 'I\'m sorry Ricky!', catch_phrase: 'I like to party!')
        expect(cal_naughton_jr.magic_idea).to eq('Bunny rabbits!')
        expect(cal_naughton_jr.steal_rickys_wife).to eq('I\'m sorry Ricky!')
        expect(cal_naughton_jr.catch_phrase).to eq('I like to party!')
    end
end 


RSpec.describe 'doubles' do
  it "tests the student's knowledge of the course's content" do
    db = double('Database Connection', connect: true, disconnect: 'Goodbye')
    expect(db.connect).to be true
    expect(db.disconnect).to eq('Goodbye')

    fs = double('File System')
    allow(fs).to receive(:read).and_return('Romeo and Juliet')
    allow(fs).to receive(:write).and_return(false)
    expect(fs.read).to eq('Romeo and Juliet')
    expect(fs.write).to be false    
  end
end