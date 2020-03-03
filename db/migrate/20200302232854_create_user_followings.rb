class CreateUserFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :user_followings do |t|
      t.references :follower, foreign_key: { to_table: :users }
      t.references :followed_user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
