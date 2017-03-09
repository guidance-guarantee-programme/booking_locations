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

    def hidden
      @data['hidden']
    end
    alias :hidden? :hidden

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

    def location_for(location_id)
      return self if id == location_id

      locations.find { |location| location.id == location_id }
    end

    def name_for(location_id)
      found = location_for(location_id)
      found ? found.name : ''
    end
  end
end
