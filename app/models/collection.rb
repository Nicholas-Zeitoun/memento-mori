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
end

