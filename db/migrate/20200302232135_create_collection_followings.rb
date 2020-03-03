class CreateCollectionFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :collection_followings do |t|
      t.references :followed_collection, foreign_key: { to_table: :collections }
      t.references :follower, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
