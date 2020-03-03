class Collection < ApplicationRecord
  belongs_to :follower
  has_many :collects, dependent: :destroy
  has_many :memes, through: :collects

  validates :name, presence: true
end
