require 'booking_locations/version'
require 'booking_locations/api'
require 'booking_locations/slot'
require 'booking_locations/location'
require 'booking_locations/null_cache'

require 'active_support/core_ext/module/attribute_accessors'

module BookingLocations
  DEFAULT_TTL = 2 * 60 * 60 # 2 hours

  mattr_writer :api
  mattr_writer :cache

  def self.api
    @@api ||= BookingLocations::Api.new
  end

  def self.cache
    @@cache ||= BookingLocations::NullCache.new
  end

  def self.find(id, expires = DEFAULT_TTL)
    cache.fetch(id, expires: expires) do
      api.get(id) do |response_hash|
        Location.new(response_hash)
      end
    end
  end
end
