require File.expand_path(File.dirname(__FILE__) + '/test_helper')

describe OpenCalais::Client do

  it "is throws 401 auth error for bad api key." do
    oc = OpenCalais::Client.new(:api_key => 'bad_KEY')
    -> { oc.enrich("Ruby on Rails is a fantastic web framework. It uses MVC, and the ruby programming language invented by Matz") }.must_raise Errors::AuthError
  end
end
