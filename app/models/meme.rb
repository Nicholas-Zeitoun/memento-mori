class Meme < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :likes
  has_many :comments
  has_one :rarity
  has_many :collects
  has_many :collections, through: :collects

  validates :image_url, presence: true
  validates :title, presence: true
end
