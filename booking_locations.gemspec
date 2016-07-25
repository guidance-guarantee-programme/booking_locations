# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'booking_locations/version'

Gem::Specification.new do |spec|
  spec.name          = 'booking_locations'
  spec.version       = BookingLocations::VERSION
  spec.authors       = ['Ben Lovell']
  spec.email         = ['benjamin.lovell@gmail.com']

  spec.summary       = 'Pension Guidance Booking Locations API adapter'
  spec.homepage      = 'https://github.com/guidance-guarantee-programme/booking_locations'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '>= 4', '< 5.1'
  spec.add_runtime_dependency 'globalid'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 2.1'
end
