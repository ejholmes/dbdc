require "bundler"
Bundler.require :default, :development

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/requests'
  config.hook_into :faraday
end
