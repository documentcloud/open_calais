module Errors
  class RaiseError < Faraday::Response::Middleware
 
    def on_complete(env)
      case env[:status]
      when 429
        raise Errors::RateLimitExceeded 
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
