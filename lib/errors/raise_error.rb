module Errors
  class RaiseError < Faraday::Response::Middleware
 
    def on_complete(env)
      raise Errors::NotFound if env[:status] == 404
      raise Errors::AuthError if env[:status] == 401
    end
 
  end
end
