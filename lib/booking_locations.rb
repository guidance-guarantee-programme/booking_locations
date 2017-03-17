require 'booking_locations/version'
require 'booking_locations/api'
require 'booking_locations/slot'
require 'booking_locations/location'

require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/cache/null_store'

module BookingLocations
  DEFAULT_PREFIX = 'booking_locations:'
  DEFAULT_TTL = 2 * 60 * 60 # 2 hours

  mattr_writer :api
  mattr_writer :cache

  def self.api
    @@api ||= BookingLocations::Api.new
  end

  def self.cache
    @@cache ||= ActiveSupport::Cache::NullStore.new
  end

  def self.find(id, expires = DEFAULT_TTL, prefix = DEFAULT_PREFIX)
    cache.fetch(prefix.concat(id), expires_in: expires) do
      api.get(id) do |response_hash|
        Location.new(response_hash)
      end
    end
  end
end
