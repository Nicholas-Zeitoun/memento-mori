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

  def init_dank_rank
    self.dank_rank = DankRank.create!(
      user_id: self.id
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
    followers + following
  end

  def creation_score
    creation = self.memes.count
  end

  def collection_score
    collections = self.collections.count
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
