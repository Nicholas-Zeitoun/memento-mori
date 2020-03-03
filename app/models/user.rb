class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :dank_rank, dependent: :destroy
  has_many :memes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # for user.followers
  has_many :followers_relations,
    foreign_key: :follower_id,
    class_name: 'UserFollowing',
    dependent: :destroy
  has_many :followers,
    through: :followers_relations

  # for user.followed_users
  has_many :followed_relations,
    foreign_key: :followed_user_id,
    class_name: 'UserFollowing',
    dependent: :destroy
  has_many :followed_users,
    through: :followed_relations

  has_many :collections, dependent: :destroy # as creator => user.collections
  has_many :collection_followings, dependent: :destroy
  # as follower => user.followed_collections
  has_many :followed_collections,
    foreign_key: :follower_id,
    class_name: 'CollectionFollowing'

  has_many :categories, dependent: :destroy # as creator => user.categories
  has_many :category_followings, dependent: :destroy
  has_many :followed_categories,
    foreign_key: :follower_id,
    class_name: 'CategoryFollowing'

  validates :username, presence: true, uniqueness: true
end
