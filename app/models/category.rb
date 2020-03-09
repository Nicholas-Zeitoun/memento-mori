class Category < ApplicationRecord
  belongs_to :user # as creation_user
  has_many :memes

  has_many :category_followings

  validates :name, presence: true, uniqueness: true

  def followers
    CategoryFollowing.where(category: self).map do |catfoll|
      catfoll.follower
    end
  end

  def follow(user_id)
    CategoryFollowing.create!(follower: User.find(user_id), category: self)
  end

  def unfollow(user_id)
    # user_to_unfollow = User.find(user_id)
    CategoryFollowing.find_by(follower: User.find(user_id)).destroy
  end

  def is_followed?(user_id)
    relationship = CategoryFollowing.find_by(category: self, follower: User.find(user_id))
    return true if relationship
  end

end
