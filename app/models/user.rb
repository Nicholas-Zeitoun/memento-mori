class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true

  has_one :dank_rank, dependent: :destroy
  has_one_attached :avatar
  has_many :memes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :user_followings, dependent: :destroy

  has_many :collections, dependent: :destroy # as creator => user.collections
  has_many :collection_followings, dependent: :destroy

  has_many :categories, dependent: :destroy # as creator => user.categories
  has_many :category_followings, dependent: :destroy


  def followed_collections
    CollectionFollowing.where(follower: self).map do |collfoll|
      collfoll.collection
    end
  end

  def followed_categories
    CategoryFollowing.where(follower: self).map do |catfoll|
      catfoll.category
    end
  end

  def followed_users
    UserFollowing.where(follower: self).map do |userfoll|
      userfoll.followed_user
    end
  end

  def followers
    UserFollowing.where(followed_user: self).map do |userfoll|
      userfoll.follower
    end
  end

  #Following funcitonality

  def follow(user_id)
    # user_to_follow = User.find(user_id)
    UserFollowing.create!(follower: self, followed_user: User.find(user_id))
  end

  def unfollow(user_id)
    # user_to_unfollow = User.find(user_id)
    UserFollowing.find_by(followed_user: User.find(user_id)).destroy
  end

  def is_following?(user_id)
    relationship = UserFollowing.find_by(follower: self, followed_user: User.find(user_id))
    return true if relationship
  end

  # Dank rank functionality

  def init_dank_rank
    self.dank_rank = DankRank.create!(
      user_id: self.id,
      engagement: 0,
      collection: 0,
      creation: 0,
      total_score: 1
    )
  end

  def set_dank_rank
    self.dank_rank.set_scores(
      engagement_score,
      creation_score,
      collection_score
    )
  end

  def get_dank_rank
    self.dank_rank.return_rank
  end

  def engagement_score
    followers = self.followers.count # should change this to engagement
    following = self.followed_users.count
    category_followings = self.followed_categories.count
    collection_followings = self.followed_collections.count + all_collection_followers
    interactions = all_comments + all_likes # need to add method for likes here
    # (followers + following + interactions) * 4
    followers + following + category_followings + collection_followings + interactions
  end

  def creation_score
    rarities = 0
    self.memes.each { |meme| rarities += meme.rarity.total_score }
    # (rarities * 3) * (self.memes.count)
    # Should add a part where users memes are collected
    rarities + self.memes.count
  end

  def collection_score
    collections = self.collections.count
    collected_memes = 0
    self.collections.each { |collection| collected_memes += collection.memes.count }
    # (collections * 4) + (collected_memes * 6)
    collected_memes + collections
  end


  private

  def all_collection_followers
    collection_followers = 0
    self.collections.each { |collection| collection_followers += collection.followers.count }
    collection_followers
  end

  def all_comments
    comment_count = 0
    # all comments on user's memes
    self.memes.each { |meme| comment_count += meme.comments.count }
    # + all comments of user
    comment_count + self.comments.count
  end

  def all_likes
    like_count = 0
    # all likes on user's memes
    self.memes.each { |meme| like_count += meme.likes.count }
    # + all likes of user
    like_count + self.likes.count
  end



  # def update_dank_rank
  #   followers = self.followers.count # should change this to engagement
  #   following = self.followed_users.count
  #   engagement = followers + following
  #   collections = self.collections.count # should also add a collection quality mod
  #   creation = self.memes.count
  #   self.dank_rank.set_scores(engagement, collections, creation)
  # end

  # def calculate_dank(engagement, collection, creation)
  #   total_score = (engagement + collection + creation) * 4
  # end
end
