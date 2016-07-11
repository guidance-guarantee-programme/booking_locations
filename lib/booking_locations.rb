require 'booking_locations/version'
require 'booking_locations/api'
require 'booking_locations/slot'
require 'booking_locations/location'

require 'active_support/core_ext/module/attribute_accessors'

module BookingLocations
  mattr_writer :api

  def self.api
    @@api ||= BookingLocations::Api.new
  end

  def self.find(id)
    api.get(id) do |response_hash|
      Location.new(response_hash)
    end
  end
end
