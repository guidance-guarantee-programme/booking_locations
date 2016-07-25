require 'ostruct'
require 'global_id'

module BookingLocations
  class Location
    include GlobalID::Identification

    def initialize(data)
      @data = data
    end

    def self.find(id)
      BookingLocations.find(id)
    end

    def id
      @data['uid']
    end

    def name
      @data['name']
    end

    def address
      @data['address']
    end

    def online_booking_twilio_number
      @data['online_booking_twilio_number']
    end

    def locations
      @locations ||= @data['locations'].map { |child_data| Location.new(child_data) }
    end

    def guiders
      @guiders ||= @data['guiders'].map { |guider| OpenStruct.new(guider) }
    end

    def slots
      @slots ||= @data['slots'].map { |slot| Slot.new(slot) }
    end

    def guider_name_for(guider_id)
      guiders.find { |guider| guider.id == guider_id }.name
    end

    def name_for(location_id)
      if id == location_id
        name
      else
        locations.find { |location| location.id == location_id }.name
      end
    end
  end
end
