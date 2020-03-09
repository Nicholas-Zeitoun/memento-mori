# app/views/api/v1/users/show.json.jbuilder
json.extract! @user, :id, :username
json.dank_rank { json.extract! @user.dank_rank, :engagement, :collection, :creation, :total_score }
