require File.expand_path(File.dirname(__FILE__) + '/test_helper')

describe OpenCalais::Client do

  before :each do
    @oc = OpenCalais::Client.new(:api_key => '')
  end

  it "should throw a AuthError for bad api key." do
    WebMock.disable!
    -> { @oc.enrich("Ruby on Rails is a fantastic web framework. It uses MVC, and the ruby programming language invented by Matz") }.must_raise Errors::AuthError
  end

  it "should throw a ServiceUnavailable error" do
    WebMock.enable!
    mock_call(:status => 503)
    -> { @oc.enrich("Test") }.must_raise Errors::ServiceUnavailable
  end

  it "should throw a ServerError error" do
    WebMock.enable!
    mock_call(:status => 500)
    -> { @oc.enrich("Test") }.must_raise Errors::ServerError
  end

  it "should throw a RateLimitExceeded error" do
    WebMock.enable!
    mock_call(:status => 429)
    -> { @oc.enrich("Test") }.must_raise Errors::RateLimitExceeded
  end

  it "should throw a BadMedia error" do
    WebMock.enable!
    mock_call(:status => 415)
    -> { @oc.enrich("Test") }.must_raise Errors::BadMedia
  end

  it "should throw a InvalidFormat error" do
    WebMock.enable!
    mock_call(:status => 406)
    -> { @oc.enrich("Test") }.must_raise Errors::InvalidFormat
  end

  it "should throw a ResourceNotFound error" do
    WebMock.enable!
    mock_call(:status => 404)
    -> { @oc.enrich("Test") }.must_raise Errors::ResourceNotFound
  end

  it "should throw a AuthError error" do
    WebMock.enable!
    mock_call(:status => 401)
    -> { @oc.enrich("Test") }.must_raise Errors::AuthError
  end

  it "should throw a BadContent error" do
    WebMock.enable!
    mock_call(:status => 400)
    -> { @oc.enrich("Test") }.must_raise Errors::BadContent
  end
end

def mock_call(options)
  stub_request(:any, /.*#{CALAIS_API}.*/).to_return(options, :headers => { 'Content-Length' => 3 })
end
