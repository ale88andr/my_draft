class DeleteCreatedAtUpdatedAtFromRolesUsers < ActiveRecord::Migration
  def change
  	remove_timestamps :roles_users
  end
end
