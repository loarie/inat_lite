class Key < ActiveRecord::Base
  attr_accessible :token, :user_id, :login
  before_save :create_remember_token
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
