class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



 
  before_create :set_default_role
  validates :role,    presence: true

  private
    def set_default_role
        self.role ||=  self.update_attribute(:role,'student')
    end

end
