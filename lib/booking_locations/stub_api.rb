module BookingLocations
  KNOWN_LOCATION_IDS = %w(
    ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef
    1a1ad00f-d967-448a-a4a6-772369fa5087
    183080c6-642b-4b8f-96fd-891f5cd9f9c7
    c165d25e-f27b-4ce9-b3d3-e7415ebaa93c
    a77a031a-8037-4510-b1f7-63d4aab7b103
    7f916cf6-d2bd-4bcc-90dc-594207c8b1f4
    43fcab23-b01f-4805-a34d-e7edb77b65ce
    fdf2fa41-b0b7-44ae-a992-4409490dc9fb
    05dbf9e9-662b-4b10-ad85-70c38bd08d6d
    13e12f95-f709-4536-b6ee-8d7a735ddf9f
    ca857ea1-e51a-442d-937d-b7c720d91ecf
    90bebb70-c4bb-4572-afb2-e4ede5ca38c9
    b5920e4c-ac91-49c3-8923-3efd10292db2
  ).freeze

  class StubApi
    def get(id)
      return nil unless KNOWN_LOCATION_IDS.include?(id)

      yield json.first
    end

    def all
      json.map do |location|
        {
          'uid'   => location['uid'],
          'title' => location['name']
        }
      end
    end

    private

    def json
      @json ||= begin
        contents = IO.read(File.join(File.dirname(File.expand_path(__FILE__)), 'stub_api.json'))
        JSON.parse(contents)
      end
    end
  end
end
