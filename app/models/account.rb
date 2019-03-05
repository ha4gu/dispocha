class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :omniauthable

  # association
  has_many :personas

  # no one can be an admin when their account is newly created
  before_create :force_not_admin
  def force_not_admin
    self.admin = false
  end

  # returns boolean whether this account has an accepted persona in the specified room
  def is_accepted_in? room
    p = room.personas.find_by(account_id: self.id)
    return false if p.nil? # false when no personas for this room
    p.accepted?
  end

end
