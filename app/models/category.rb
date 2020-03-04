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
end
