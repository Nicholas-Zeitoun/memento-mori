class CreateCollects < ActiveRecord::Migration[5.2]
  def change
    create_table :collects do |t|
      t.references :collection, foreign_key: true
      t.references :meme, foreign_key: true

      t.timestamps
    end
  end
end
