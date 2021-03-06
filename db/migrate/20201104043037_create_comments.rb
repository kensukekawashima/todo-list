class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :comment
      t.references :user, foreign_key: true, index: true
      t.references :task, foreign_key: true, index: true

      t.timestamps
    end
  end
end
