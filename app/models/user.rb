class User < ApplicationRecord
  before_save{self.email = email.downcase}
  validates :name, presence: true,
                      length: {maximum: Settings.users.name.maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
                      length: {maximum: Settings.users.email.maximum},
                        format: {with: VALID_EMAIL_REGEX},
                          uniqueness: {case_sensitive: false}
  validates :password, presence: true,
                        length: {minimum: Settings.users.password.minimum}
  has_secure_password
end
