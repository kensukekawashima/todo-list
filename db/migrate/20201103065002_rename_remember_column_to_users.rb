class RenameRememberColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :remember, :remember_digest
  end
end
