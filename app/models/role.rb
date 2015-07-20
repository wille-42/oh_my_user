class Role < ActiveRecord::Base
  has_many :permissions, dependent: :destroy
  has_and_belongs_to_many :staffs

  validates :name, presence: true, uniqueness: true
end
