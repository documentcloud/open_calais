#Dir["errors/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

module Errors
  class RaiseError < Faraday::Response::Middleware
 
    def on_complete(env)
      case env[:status]
      when 503
        raise Errors::ServiceUnavailable
      when 500
        raise Errors::ServerError
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
