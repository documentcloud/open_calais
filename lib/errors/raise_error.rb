require "errors/rate_limit_exceeded"
require "errors/denied_error"
require "errors/auth_error"
require "errors/bad_content"
require "errors/resource_not_found"

module Errors
  class RaiseError < Faraday::Response::Middleware
 
    def on_complete(env)
      case env[:status]
      when 429
        raise Errors::RateLimitExceeded 
      when 415
        raise Errors::BadMedia
      when 413
        raise Errors::LargeEntity
      when 406
        raise Errors::InvalidFormat
      when 404
        raise Errors::ResourceNotFound
      when 401
        raise Errors::AuthError
      when 400
        raise Errors::BadContent
      end
    end
 
  end
end
