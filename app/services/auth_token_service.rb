class AuthTokenService
    ALGORITHM_TYPE = "HS256"
    HMAC_SECRET_KEY = "JOGGING"

    def self.call(user)
        JWT.encode UserSerializer.new(user).serialized_json, HMAC_SECRET_KEY, ALGORITHM_TYPE
    end
end