class User < ApplicationRecord
  before_save :mail
  validates :name, presence: true,
                      length: {maximum: Settings.users.name.maximum}
  validates :email, presence: true,
                      length: {maximum: Settings.users.email.size},
                        format: {with: Settings.users.email.valid},
                          uniqueness: {case_sensitive: false}
  validates :password, presence: true,
                        length: {minimum: Settings.users.password.size}

  private

  def mail
    email.downcase!
  end
  has_secure_password
end
