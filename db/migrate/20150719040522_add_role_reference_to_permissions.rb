class AddRoleReferenceToPermissions < ActiveRecord::Migration
  def change
    add_reference :permissions, :role, index: true, foreign_key: true
  end
end
