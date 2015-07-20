class Permission < ActiveRecord::Base
  belongs_to :role
  has_many :staffs, through: :role

  validates :resource, presence: true
  validates :action, presence: true
end
