json.name @user.username
json.value @user.dank_rank.rank_up_xp_progress

json.children do
  json.array! [@user] do |user|
    json.name "Creations"
    json.value @user.memes.count*6
    json.children @user.memes do |meme|
      json.name meme.title
      json.value meme.rarity[:total_score]
    end
  end

  json.array! [@user] do |user|
    json.name "Collections"
    json.value @user.collections.count*7
    json.children @user.collections do |collection|
      json.name collection.name
      json.children collection.memes do |meme|
        json.name meme.title
        json.value meme.rarity[:total_score]
      end
    end
  end
end
