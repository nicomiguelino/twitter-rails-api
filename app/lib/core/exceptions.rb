module Core::Exceptions
  class MissingJWTCookieError < StandardError
    def initialize(msg='JSON Web Token not found.')
      super
    end
  end
end
