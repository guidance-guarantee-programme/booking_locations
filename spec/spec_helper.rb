$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'booking_locations'

require 'vcr'
require 'webmock/rspec'

RSpec.configure do |config|
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.order = :random
  config.profile_examples = 10

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.configure_rspec_metadata!
  config.hook_into :webmock
end
