class Collection < ApplicationRecord
  belongs_to :user
  has_many :collects, dependent: :destroy
  has_many :memes, through: :collects

  has_many :collection_followings

  validates :name, presence: true

  def followers
    CollectionFollowing.where(collection: self).map do |collfoll|
      collfoll.follower
    end
  end

  def follow(user_id)
    CollectionFollowing.create!(follower: User.find(user_id), collection: self)
  end

  def unfollow(user_id)
    # user_to_unfollow = User.find(user_id)
    CollectionFollowing.find_by(follower: User.find(user_id)).destroy
  end

  def is_followed?(user_id)
    relationship = CollectionFollowing.find_by(collection: self, follower: User.find(user_id))
    return true if relationship
  end
end

