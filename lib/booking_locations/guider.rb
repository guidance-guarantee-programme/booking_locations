module BookingLocations
  class Guider
    def initialize(data)
      @data = data
    end

    def id
      @data['id']
    end

    def name
      @data['name']
    end

    def email
      @data['email']
    end

    def self.model_name
      OpenStruct.new(name: 'Guider')
    end
  end
end
