class Role < ActiveRecord::Base
  RESERVED = %w(admin)

  has_many :permissions, dependent: :destroy
  has_and_belongs_to_many :staffs

  validates :name, presence: true, uniqueness: true

  scope :editable, -> { where.not(name: RESERVED ) }
end
