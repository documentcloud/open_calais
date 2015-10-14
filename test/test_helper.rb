# -*- encoding: utf-8 -*-

require 'simplecov'
SimpleCov.start

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

require 'minitest/spec'
require 'minitest/autorun'
require 'byebug'

require 'open_calais'

require 'webmock'
include WebMock::API
CALAIS_API = "api.thomsonreuters.com"

WebMock.disable!
