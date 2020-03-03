class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :meme

  validates :content, presence: true
end
