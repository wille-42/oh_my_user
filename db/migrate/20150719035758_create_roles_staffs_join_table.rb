class CreateRolesStaffsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :roles, :staffs do |t|
      t.index [:role_id, :staff_id]
      t.index [:staff_id, :role_id]
    end
  end
end
