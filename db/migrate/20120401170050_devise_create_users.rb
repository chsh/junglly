class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :facebook_user_id, null: false
      t.text :facebook_profile
      t.timestamps
    end
    add_index :users, :facebook_user_id, unique: true
  end
end
