require 'booking_locations/version'
require 'booking_locations/api'
require 'booking_locations/slot'
require 'booking_locations/location'

require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/cache/null_store'

module BookingLocations
  DEFAULT_PREFIX = 'booking_locations:'.freeze
  DEFAULT_TTL = 2 * 60 * 60 # 2 hours

  mattr_writer :api
  mattr_writer :cache

  def self.api
    @@api ||= BookingLocations::Api.new
  end

  def self.cache
    @@cache ||= ActiveSupport::Cache::NullStore.new
  end

  def self.find(id, expires = DEFAULT_TTL)
    cache.fetch(cache_prefix(id), expires_in: expires) do
      api.get(id) do |response_hash|
        Location.new(response_hash)
      end
    end
  end

  def self.clear_cache
    cache.delete_matched(cache_prefix('*'))
  end

  def self.cache_prefix(key)
    DEFAULT_PREFIX.dup.concat(key)
  end
end
