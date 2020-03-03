class CreateCategoryFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :category_followings do |t|
      t.references :follower, foreign_key: { to_table: :users }
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
