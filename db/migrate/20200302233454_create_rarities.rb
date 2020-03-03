class CreateRarities < ActiveRecord::Migration[5.2]
  def change
    create_table :rarities do |t|
      t.integer :comments
      t.integer :likes
      t.integer :shares
      t.integer :collects
      t.integer :total_score
      t.references :meme, foreign_key: true

      t.timestamps
    end
  end
end
