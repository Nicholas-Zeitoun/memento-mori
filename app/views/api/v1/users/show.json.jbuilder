# app/views/api/v1/users/show.json.jbuilder
json.extract! @user, :id, :username

json.dank_rank { json.extract! @user.dank_rank, :engagement,
  :collection,
  :creation,
  :rank_up_bar,
  :rank_up_xp_progress,
  :rank_up_xp_required,
  :total_score }

json.stats {
  json.creations @user.memes do |meme|
    json.extract! meme, :title
    json.extract! meme.rarity, :total_score
  end

  json.collections @user.collections do |collection|
    json.extract! collection, :name
    json.memes collection.memes do |meme|
      json.extract! meme, :title
      json.extract! meme.rarity, :total_score
    end
  end
}
