class Rarity < ApplicationRecord
  belongs_to :meme

  def set_score(likes, comments, collects)
    self.likes = likes
    self.comments = comments
    self.collects = collects
    self.total_score = self.likes + self.comments + self.collects
    self.save!
  end
end
