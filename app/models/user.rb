class User < ApplicationRecord
  before_save :mail
  validates :name, presence: true,
                      length: {maximum: Settings.name_maximum}
  validates :email, presence: true,
                      length: {maximum: Settings.email_maximum},
                        format: {with: Settings.email_valid},
                          uniqueness: {case_sensitive: false}
  validates :password, presence: true,
                        length: {minimum: Settings.minimum_pass}

  private

  def mail
    email.downcase!
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end
  has_secure_password
end
