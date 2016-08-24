RSpec.describe BookingLocations do
  it 'defaults `api`' do
    expect(BookingLocations.api).to be_a(BookingLocations::Api)
  end

  describe '.find' do
    context 'when the location is present' do
      let(:api) { instance_double(BookingLocations::Api) }
      let(:id) { '9d7c72fc-0c74-4418-8099-e1a4e704cb01' }
      let(:response) { Hash.new }
      let(:cache) { double }
      let(:ttl) { BookingLocations::DEFAULT_TTL }

      before do
        BookingLocations.api = api

        allow(api).to receive(:get).with(id).and_yield(response)
        allow(cache).to receive(:fetch).with(id, expires: ttl).and_yield
      end

      it 'returns the `Location`' do
        expect(BookingLocations.find(id)).to be_a(BookingLocations::Location)
      end

      context 'when the cache store is configured' do
        it 'reads-through the cache' do
          with_cache(cache) do
            expect(cache).to receive(:fetch).with(id, expires: 10).and_yield

            BookingLocations.find(id, 10)
          end
        end
      end

      context 'when the cache is not configured' do
        it 'defaults to Rails null store' do
          expect(BookingLocations.cache).to be_an(ActiveSupport::Cache::NullStore)
        end
      end

      def with_cache(cache)
        current = BookingLocations.cache
        BookingLocations.cache = cache
        yield
      ensure
        BookingLocations.cache = current
      end
    end
  end
end
