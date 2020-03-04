class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true

  has_one :dank_rank, dependent: :destroy
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
end
