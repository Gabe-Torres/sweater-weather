class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_secure_token :api_key
  has_secure_password
end
