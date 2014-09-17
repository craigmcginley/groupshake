class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.string :title, null: false
      t.integer :total_scenes, null: false

      t.timestamps
    end
  end
end
