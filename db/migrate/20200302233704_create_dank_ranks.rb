class CreateDankRanks < ActiveRecord::Migration[5.2]
  def change
    create_table :dank_ranks do |t|
      t.integer :engagement
      t.integer :collection
      t.integer :creation
      t.integer :total_score
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
