class Meme < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :likes
  has_many :comments
  has_one :rarity
  has_many :collects
  has_many :collections, through: :collects
  has_one_attached :image

  #validates :image_url, presence: true, unless: meme.image.present?
  validates :image_url, presence: true, unless: :image
  validates :image, presence: true, unless: :image_url

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

  def update_rarity
    self.rarity.set_score(self.likes.count, self.comments.count, self.collects.count)
  end

  # validates :title, presence: true
  # validates :photo, presence: true
  # validates :category, presence: true

end
