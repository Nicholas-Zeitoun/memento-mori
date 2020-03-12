class Rarity < ApplicationRecord
  belongs_to :meme

  def set_score(likes, comments, collects)
    self.likes = likes
    self.comments = comments
    self.collects = collects
    self.total_score = self.likes + self.comments + self.collects
    self.save!
  end

  def get_rarity
    if self.total_score > 100
      'dank-rank.png'
    elsif self.total_score > 90
      'diamond-rank.png'
    elsif self.total_score > 80
      'emerald-rank.png'
    elsif self.total_score > 70
      'ruby-rank.png'
    elsif self.total_score > 60
      'sapphire-rank.png'
    elsif self.total_score > 50
      'gold-rank.png'
    elsif self.total_score > 20
      'silver-rank.png'
    elsif self.total_score > 10
      'bronze-rank.png'
    else
     'blank-rank.png'
   end
  end

  #test comment
end
