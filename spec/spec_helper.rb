require "bundler"
Bundler.require :default, :development

RSpec.configure do |config|
end

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/requests'
  config.hook_into :faraday
end
