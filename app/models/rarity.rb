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
    case self.total_score
    when 1
      'blank-rank.png'
    when 2
      'bronze-rank.png'
    when 3
      'silver-rank.png'
    when 4
      'gold-rank.png'
    when 5
      'sapphire-rank.png'
    when 6
      'ruby-rank.png'
    when 7
      'emerald-rank.png'
    when 8
      'diamond-rank.png'
    when 9
      'diamond-rank.png'
    else
      'dank-rank.png'
    end
  end
end
