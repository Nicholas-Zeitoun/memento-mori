json.array! @users do |user|
  json.extract! user, :id, :username
  json.level user.dank_rank.total_score
  json.score user.dank_rank.rank_up_xp_progress
  json.avatar cl_image_path(user.avatar.key)
end
