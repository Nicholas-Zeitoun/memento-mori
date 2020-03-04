class Collection < ApplicationRecord
  belongs_to :user
  has_many :collects, dependent: :destroy
  has_many :memes, through: :collects

  validates :name, presence: true
end

