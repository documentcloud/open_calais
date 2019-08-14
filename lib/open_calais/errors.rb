module OpenCalais
  module Errors

    class AuthError < StandardError
    end

    class BadContent < StandardError
    end

    class BadMedia < StandardError
    end

    class InvalidFormat < StandardError
    end

    class LargeEntity < StandardError
    end

    class RateLimitExceeded < StandardError
    end

    class ResourceNotFound < StandardError
    end

    class ServerError < StandardError
    end

    class ServiceUnavailable < StandardError
    end

    class Handler < Faraday::Response::Middleware
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
end