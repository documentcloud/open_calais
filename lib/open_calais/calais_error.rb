module Errors
  class CalaisError < Faraday::Response::Middleware
 
    def on_complete(env)
      raise Errors::NotFound if env[:status] == 404
    end
 
  end
end
