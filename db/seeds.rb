# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Meme.delete_all
# Category.delete_all
# Collection.delete_all
# CategoryFollowing.delete_all
# CollectionFollowing.delete_all

User.delete_all
puts 'making them users'
user1 = User.create!(email: "bob@user.com",
  password: "password", username: "bob")
user2 = User.create!(email: "marty@user.com",
  password: "password", username: "marty")
puts 'danking them rankings'

user1_dank_rank = DankRank.new(total_score: 150, user_id: user1.id)
user1.dank_rank = user1_dank_rank
user2_dank_rank = DankRank.new(total_score: 100, user_id: user2.id)
user2.dank_rank = user2_dank_rank
puts 'making dat fat category'
animal_category = Category.create!(user: user1, name: 'animal category')
puts 'memeing it up'
catmeme = Meme.create!(title: 'cat meme', image_url: 'catmeme.jpg', category: animal_category, user: user1)
dogmeme = Meme.create!(title: 'dog meme', image_url: 'dogmeme.jpg', category: animal_category, user: user1)
birdmeme = Meme.create!(title: 'bird meme', image_url: 'birdmeme.jpg', category: animal_category, user: user1)
user1.memes << catmeme << dogmeme << birdmeme
puts 'martys making a collection!'
user2s_collection = Collection.create!(name: 'martys collection', user: user2)
user2.collections << user2s_collection
cat_meme_collect = Collect.create!(collection: user2.collections.first, meme: catmeme)
puts 'liking some memes'
cm_like_1 = Like.create!(user: user1, meme: catmeme)
cm_like_2 = Like.create!(user: user1, meme: catmeme)
cm_like_3 = Like.create!(user: user1, meme: catmeme)
catmeme.likes << cm_like_1 << cm_like_2 << cm_like_3
