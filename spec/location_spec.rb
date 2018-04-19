RSpec.describe BookingLocations::Location do
  let(:data) do
    {
      'uid' => '9d7c72fc-0c74-4418-8099-e1a4e704cb01',
      'name' => 'Somewhere CAB',
      'title' => 'Somewhere CAB',
      'address' => '10 Some Place',
      'online_booking_twilio_number' => '+44345567890',
      'online_booking_reply_to' => 'dave@example.com',
      'hidden' => false,
      'locations' => [
        {
          'uid' => '1d7c72fc-0c74-4418-8099-e1a4e704cb01',
          'name' => 'Child CAB',
          'address' => '10 Child Address',
          'online_booking_twilio_number' => '',
          'online_booking_reply_to' => '',
          'hidden' => false
        }
      ],
      'guiders' => [
        {
          'id' => 1,
          'name' => 'Rick Sanchez',
          'email' => 'rick@example.com'
        }
      ]
    }
  end

  subject { described_class.new(data) }

  it 'supports GlobalID serialization / deserialization' do
    expect(described_class).to include(GlobalID::Identification)
    expect(described_class).to respond_to(:find)
  end

  it 'has an ID' do
    expect(subject.id).to eq('9d7c72fc-0c74-4418-8099-e1a4e704cb01')
  end

  it 'has a name' do
    expect(subject.name).to eq('Somewhere CAB')
  end

  it 'has a title' do
    expect(subject.title).to eq('Somewhere CAB')
  end

  it 'has an address' do
    expect(subject.address).to eq('10 Some Place')
  end

  it 'has an online booking twilio number' do
    expect(subject.online_booking_twilio_number).to eq('+44345567890')
  end

  it 'has an online booking reply-to' do
    expect(subject.online_booking_reply_to).to eq('dave@example.com')
  end

  it 'has a flag to indicate when it is hidden' do
    expect(subject).not_to be_hidden
  end

  it 'has nested locations' do
    child = subject.locations.first

    expect(child.id).to eq('1d7c72fc-0c74-4418-8099-e1a4e704cb01')
    expect(child.name).to eq('Child CAB')
    expect(child.address).to eq('10 Child Address')
    expect(child.online_booking_twilio_number).to eq('')
    expect(child.online_booking_reply_to).to eq('')
  end

  it 'has guiders' do
    expect(subject.guiders.first.id).to eq(1)
    expect(subject.guiders.first.name).to eq('Rick Sanchez')
    expect(subject.guiders.first.email).to eq('rick@example.com')
  end

  describe '#name_for' do
    context 'with a location ID representing the booking location' do
      it 'returns the booking location name' do
        expect(subject.name_for('9d7c72fc-0c74-4418-8099-e1a4e704cb01')).to eq('Somewhere CAB')
      end
    end

    context 'with a location ID representing a child location' do
      it 'returns the child location name' do
        expect(subject.name_for('1d7c72fc-0c74-4418-8099-e1a4e704cb01')).to eq('Child CAB')
      end
    end

    context 'with a non-existent location ID' do
      it 'returns an empty string' do
        expect(subject.name_for('deadbeef-dead-beef-beef-deadbeefdead')).to eq('')
      end
    end
  end

  describe '#guider_name_for' do
    it 'returns the guider name for the given ID' do
      expect(subject.guider_name_for(1)).to eq('Rick Sanchez')
    end
  end

  describe '#location_for' do
    it 'returns the location for the give ID' do
      expect(subject.location_for('9d7c72fc-0c74-4418-8099-e1a4e704cb01')).to eq(subject)
    end
  end
end
