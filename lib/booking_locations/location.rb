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

    def title
      @data['title']
    end

    def address
      @data['address']
    end

    def accessibility_information
      @data['accessibility_information']
    end

    def online_booking_twilio_number
      @data['online_booking_twilio_number']
    end

    def online_booking_reply_to
      @data['online_booking_reply_to']
    end

    def online_booking_weekends
      @data['online_booking_weekends']
    end
    alias :online_booking_weekends? :online_booking_weekends

    def hidden
      @data['hidden']
    end
    alias :hidden? :hidden

    def realtime
      @data['realtime']
    end
    alias :realtime? :realtime

    def organisation
      @data['organisation']
    end

    def coordinates
      @data.dig('geometry', 'coordinates')
    end

    def locations
      @locations ||= @data['locations'].map { |child_data| Location.new(child_data) }
    end

    def guiders
      @guiders ||= @data['guiders'].map { |guider| OpenStruct.new(guider) }
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
