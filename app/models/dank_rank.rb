class DankRank < ApplicationRecord
  belongs_to :user

  def set_scores(engagement_score, collection_score, creation_score)
    puts 'setting scores...'
    self.engagement = engagement_score;
    self.collection = collection_score;
    self.creation = creation_score;
    self.save!
  end

  def return_rank
    the_algorithm_of_dankness
  end

  private

  def the_algorithm_of_dankness
    (self.engagement + self.collection + self.creation) * 4
  end
end
