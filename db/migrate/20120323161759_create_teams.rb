class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.text :members_text
      t.date :started_at
      t.text :members
      t.timestamps
    end
  end
end
