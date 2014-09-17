class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :play_id, null: false
      t.string :name, null: false
      t.integer :lines_spoken, default: 0
      t.integer :longest_speech, default: 0
      t.integer :scene_count, default: 0
      t.float :scene_percentage, default: 0.0

      t.timestamps
    end
  end
end
