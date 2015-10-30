#Dir["errors/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

module CalaisError
  class RaiseError < Faraday::Response::Middleware
 
    def on_complete(env)
      case env[:status]
      when 503
        raise CalaisError::ServiceUnavailable
      when 500
        raise CalaisError::ServerError
      when 429
        raise CalaisError::RateLimitExceeded 
      when 415
        raise CalaisError::BadMedia
      when 413
        raise CalaisError::LargeEntity
      when 406
        raise CalaisError::InvalidFormat
      when 404
        raise CalaisError::ResourceNotFound
      when 401
        raise CalaisError::AuthError
      when 400
        raise CalaisError::BadContent
      end
    end
 
  end
end
