require 'jwt'

class Token < ApplicationRecord
  before_save :default_values

  def default_values
    # just an example, secret should be at least 256 bit and randomly generated
    # and stored in this record
    hmac_secret = 'my$ecretK3y'

    # in this case, this token only allows you to 'retrieve' applicationId 1234
    payload = { applicationId: '1234', exp: self.expiration, per: self.permission}
    self.token = JWT.encode payload, hmac_secret, 'HS256'
  end
end
