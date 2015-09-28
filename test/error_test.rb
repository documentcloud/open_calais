require File.expand_path(File.dirname(__FILE__) + '/test_helper')

describe OpenCalais::Client do

  it "is initialized with defaults" do
    oc = OpenCalais::Client.new
    oc.current_options.wont_be_nil
    oc.current_options.must_equal OpenCalais.options
  end
end
