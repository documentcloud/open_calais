require "errors/denied_error"
require "errors/not_found"

module Errors
  class RaiseError < Faraday::Response::Middleware
 
    def on_complete(env)
      raise Errors::NotFound if env[:status] == 404
      raise Errors::DeniedError if env[:status] == 401
    end
 
  end
end
