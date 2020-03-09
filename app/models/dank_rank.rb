class DankRank < ApplicationRecord
  belongs_to :user

  def set_scores(engagement_score, creation_score, collection_score)
    puts 'setting scores...'
    self.engagement = engagement_score;
    self.collection = collection_score;
    self.creation = creation_score;
    # self.total_score = self.return_rank;
    if rank_up?
      rank_up!
      dank_helper
    else
      puts "not ranking up"
      dank_helper
    end
    # self.total_score = rank_up? ? rank_up! : self.total_score
    self.save!
  end

  def return_rank
    self.total_score
    # rank_up?
    # total_exp = get_total_exp
  end

  def rank_up_xp_progress
    next_rank = self.total_score + 1
    rank_up_xp_required - (next_rank_req_exp(next_rank) - get_total_exp)
  end

  def rank_up_xp_required
    next_rank = self.total_score + 1
    ((( next_rank - 1 ) + ( 300 * yaw_constant(next_rank)) ) / 4 ).to_i
  end

  def rank_up_bar
    bar_percentage = (rank_up_xp_progress / rank_up_xp_required.to_f) * 100
    bar_percentage.to_i
  end

  def rank_up!
    puts "ranking up!"
    self.total_score = self.total_score += 1
  end

  def rank_up?
    get_total_exp > next_rank_req_exp(self.total_score + 1)
  end

  private

  def get_total_exp
    (self.engagement + self.collection + self.creation) * 4
  end

  def next_rank_req_exp(next_rank)
    yaw = yaw_constant(next_rank)

    required_exp = 0;
    next_rank.times do |index|
      rank = index + 1
      unless rank == 1
        required_exp += ((( rank - 1 ) + ( 300 * yaw_constant(rank)) ) / 4 ).to_i
      end
    end

    required_exp
  end

  def yaw_constant(x)
    x_minus_one_over_seven = ((x - 1) / 7.to_f)
    2 ** x_minus_one_over_seven
  end

  def dank_helper
    current_rank = self.total_score
    next_rank = self.total_score + 1
    puts "Current dank rank: #{current_rank}"
    puts "Next dank rank: #{next_rank}"
    puts "Total current exp: #{get_total_exp}"
    puts "Next rank required exp: #{next_rank_req_exp(next_rank)}"
  end
end
