class Actor 
    attr_reader :name, :specialty, :age, :gender 
    def initialize(name:, specialty:, age:, gender:, ready: false)
        @name = name
        @specialty = specialty
        @age = age
        @gender = gender
        @ready = ready
    end

    def to_s
        "#{@name} is a #{@age}-year-old #{@gender} actor specializing in #{@specialty}."
    end

    def act
        "Let's break a leg!"
    end

    def rehearse
        "Rehearsing my lines."
    end

    def ready?
        sleep(3)
        puts "#{@name} is ready for the performance."
        true 
    end
    def perform
        puts "#{@name} is performing!"
    end

    def rest
        puts "#{@name} is taking a break."
        sleep(2)
        puts "#{@name} is back from the break."
    end
    
    def audition    
        puts "#{@name} is auditioning for a role."
        sleep(1)
        puts "#{@name} has finished auditioning."
    end

    def fall_off_ladder
        puts "#{@name} has fallen off the ladder!"
        sleep(1)
        puts "#{@name} is back on their feet."
    end
end

class Movie 
    attr_reader :title, :director, :release_year, :genre, :cast
    def initialize(title:, director:, release_year:, genre:, cast: [])
        @title = title
        @director = director
        @release_year = release_year
        @genre = genre
        @cast = cast
    end

    def ready_to_shoot?
        # All cast members must be read
        @cast.all?(&:ready?)
    end

    def shoot_scene(scene_name)
        if ready_to_shoot?
            puts "Shooting scene: #{scene_name}"
            @cast.each do |actor|
                actor.perform
                actor.rest
            end
            puts "Scene '#{scene_name}' has been shot successfully."
        else
            puts "Cannot shoot scene '#{scene_name}' because not all actors are ready."
        end
    end
    def add_actor(actor)
        @cast << actor
    end

    def to_s
        "Movie: #{@title}, Directed by: #{@director}, Released in: #{@release_year}, Genre: #{@genre}, Cast: #{@cast.map(&:name).join(', ')}"
    end
end

RSpec.describe Movie do
    let (:stuntman) {double('Mr. Danger', name: 'Mr. Danger', specialty: 'Stunts', age: 30, gender: 'Male', ready: true)}
    let (:romantic_lead) {double('Ms. Heartthrob', name: 'Ms. Heartthrob', specialty: 'Romance', age: 28, gender: 'Female', ready: true)}

    # create a movie subject with the mocked actor
    subject { described_class.new(title: 'Action-Packed Romance', director: 'Jane Smith', release_year: 2023, genre: 'Action/Romance', cast: [stuntman, romantic_lead]) }

    describe '#shoot_scene' do
        it 'shoots a scene when all actors are ready' do
            allow(stuntman).to receive(:ready?).and_return(true)
            allow(romantic_lead).to receive(:ready?).and_return(true)
            allow(stuntman).to receive(:perform).and_return('Performing a stunt!')
            allow(romantic_lead).to receive(:perform).and_return('Performing a romantic scene!')
            allow(stuntman).to receive(:rest).and_return('Resting after the stunt!')
            allow(romantic_lead).to receive(:rest).and_return('Resting after the scene!')

            # expect(stuntman).to receive(:ready?).exactly(1).times # or .once
            # expect(romantic_lead).to receive(:ready?).exactly(1).times # or .once
            # expect(stuntman).to receive(:perform).exactly(1).times # or .once
            # expect(romantic_lead).to receive(:perform).exactly(1).times # or .once
            # expect(stuntman).to receive(:rest).exactly(1).times # or .once
            # expect(romantic_lead).to receive(:rest).exactly(1).times # or .once
            
            expect { subject.shoot_scene('The Big Chase') }.to output(/Shooting scene: The Big Chase/).to_stdout
            
            # What should have happened? 
            expect(stuntman).to have_received(:ready?).once # or .exactly(1).times
            expect(romantic_lead).to have_received(:ready?).once # or .exactly(1).times
            expect(stuntman).to have_received(:perform).once # or .exactly(1).times
            expect(romantic_lead).to have_received(:perform).once 
            expect(stuntman).to have_received(:rest).once
            expect(romantic_lead).to have_received(:rest).once

        end

        it 'does not shoot a scene if not all actors are ready' do
            allow(stuntman).to receive(:ready?).and_return(false)
            allow(romantic_lead).to receive(:ready?).and_return(true)
            allow(stuntman).to receive(:perform).and_return('Performing a stunt!')
            allow(romantic_lead).to receive(:perform).and_return('Performing a romantic scene!')
            allow(stuntman).to receive(:rest).and_return('Resting after the stunt!')
            allow(romantic_lead).to receive(:rest).and_return('Resting after the scene!')
            # Expect the output to indicate that the scene cannot be
            expect { subject.shoot_scene('The Big Chase') }.to output(/Cannot shoot scene 'The Big Chase' because not all actors are ready/).to_stdout
            expect(stuntman).not_to have_received(:perform)
            expect(romantic_lead).not_to have_received(:perform)
        end
    end     
    describe '#ready_to_shoot?' do
        it 'returns true when all actors are ready' do
            allow(stuntman).to receive(:ready?).and_return(true)
            allow(romantic_lead).to receive(:ready?).and_return(true)
            expect(subject.ready_to_shoot?).to be true
        end

        it 'returns false when at least one actor is not ready' do
            allow(stuntman).to receive(:ready?).and_return(true)
            allow(romantic_lead).to receive(:ready?).and_return(false)
            expect(subject.ready_to_shoot?).to be false
        end
    end

    describe '#add_actor' do
        it 'adds an actor to the cast' do
            new_actor = double('Male', name: 'Newbie', specialty: 'Comedy', age: 25, gender: 'Male') 
            expect {subject.add_actor(new_actor)}.to change { subject.cast.size }.by(1)
            expect(subject.cast.last.name).to eq('Newbie')
            expect(subject.cast.last.specialty).to eq('Comedy')
            expect(subject.cast.last.age).to eq(25)
            expect(subject.cast.last.gender).to eq('Male')
            expect(subject.cast).to include(new_actor)
        end
    end
end 