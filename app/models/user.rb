class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :registerable
  # :recoverable, :rememberable, :trackable
  devise :database_authenticatable
  # After reading the instructions again, devise' database authenticable solution
  # seems to be more robust of a solution than was needed:
  # 'foobar' is the default password *not* the required password

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :admin
  
  
  before_create :set_default_password
  
  validates :email, :presence => true, :format => {:with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b$/i},
                    :uniqueness => true

  def admin?
    admin
  end
  
  private 
  
  def set_default_password
    self.password = 'foobar' if password.nil?
  end
end
