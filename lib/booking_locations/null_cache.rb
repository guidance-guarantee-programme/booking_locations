module BookingLocations
  class NullCache
    def fetch(*)
      yield
    end
  end
end
