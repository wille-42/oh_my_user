class Staff < ActiveRecord::Base
  has_secure_password

  has_and_belongs_to_many :roles
  has_many :permissions, through: :roles

  validates :name, presence: true, uniqueness: true

  def has_role?(role)
    if role.is_a?(Role)
      roles.exists?(role)
    else
      roles.exists?(name: role)
    end
  end

  def add_role(role)
    role = role.is_a?(Role) ? role : Role.find_by_name!(role)
    roles << role unless has_role?(role)
  end

  def remove_role(role)
    role = role.is_a?(Role) ? role : Role.find_by_name!(role)
    roles.delete(role) if has_role?(role)
  end
end
