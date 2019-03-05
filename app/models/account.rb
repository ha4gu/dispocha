class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :omniauthable

  # no one can be an admin when its instance is newly created
  before_create :force_not_admin

  def force_not_admin
    self.admin = false
  end

end
