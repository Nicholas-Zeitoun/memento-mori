class Category < ApplicationRecord
  belongs_to :user # as creation_user
  has_many :users, through: :category_followings # as followers
  has_many :memes

  validates :name, presence: true, uniqueness: true
end
