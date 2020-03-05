class Meme < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :likes
  has_many :comments
  has_one :rarity
  has_many :collects
  has_many :collections, through: :collects
  # has_one_attached :photo

  validates :image_url, presence: true
  validates :title, presence: true

  def set_rarity
    likes = self.likes.count
    collects = self.collects.count
    comments = self.comments.count
    total_score = likes + collects + comments
    self.rarity = Rarity.create!(
      comments: self.comments.count,
      likes: self.likes.count,
      collects: self.collects.count,
      total_score: total_score,
      meme: self
    )
  end

  # validates :title, presence: true
  # validates :photo, presence: true
  # validates :category, presence: true 

end
