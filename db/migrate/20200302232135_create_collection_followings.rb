class CreateCollectionFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :collection_followings do |t|
      t.references :collection, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
