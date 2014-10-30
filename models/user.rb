require 'bcrypt'
class User < ActiveRecord::Base
  validates :username, uniqueness: true
  include BCrypt

    def self.authenticated?(username, password)
      user = self.find_by(username: username)
      user && user.password == password
    end

    def password
      @password ||= Password.new(self.password_hash)
    end

    def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    end
end