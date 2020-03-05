class DankRank < ApplicationRecord
  belongs_to :user

  def set_scores(engagement_score, collection_score, creation_score)
    puts 'setting scores...'
    puts engagement_score
    self.engagement = engagement_score;
    self.collection = collection_score;
    self.creation = creation_score;
    self.save!
  end
end
