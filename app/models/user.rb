class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :registerable
  # :recoverable, :rememberable, :trackable
  devise :database_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  before_create :set_default_password
  
  validates :email, :presence => true
  
  private 
  
  def set_default_password
    self.password = 'foobar' if password.nil?
  end
end
