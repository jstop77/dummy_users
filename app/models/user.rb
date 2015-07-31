class User < ActiveRecord::Base
  validates :email, uniqueness: true
  # Remember to create a migration!
  def self.authenticate(email, password)
    if self.where(email: email)[0] == self.where(password: password)[0]
      return self.where(email: email).first
    else
      return nil
    end
  end

end