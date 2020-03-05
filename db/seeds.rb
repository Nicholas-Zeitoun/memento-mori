# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'making them users'

user1 = User.create!(email: "bob@user.com",
  password: "password", username: "bob")

user2 = User.create!(email: "marty@user.com",
  password: "password", username: "marty")

user3 = User.create!(email: "sheila@user.com",
  password: "password", username: "sheila")

user4 = User.create!(email: "max@user.com",
  password: "password", username: "max")

# user1_dank_rank = DankRank.new(total_score: 150, user_id: user1.id)
# user1.dank_rank = user1_dank_rank

# user2_dank_rank = DankRank.new(total_score: 100, user_id: user2.id)
# user2.dank_rank = user2_dank_rank

# user3_dank_rank = DankRank.new(total_score: 127, user_id: user3.id)
# user3.dank_rank = user3_dank_rank

# user4_dank_rank = DankRank.new(total_score: 90, user_id: user4.id)
# user4.dank_rank = user4_dank_rank

puts 'making dat fat category'

animal_category = Category.create!(user: user1, name: 'animal category')
dog_category = Category.create!(user: user1, name: 'dog category')
cat_category = Category.create!(user: user1, name: 'cat category')

puts 'memeing it up'

catmeme = Meme.create!(
  title: 'cat meme',
  image_url: 'https://www.dailydot.com/wp-content/uploads/2018/10/olli-the-polite-cat.jpg',
  category: animal_category,
  user: user1
)
dogmeme = Meme.create!(
  title: 'dog meme',
  image_url: 'https://moderndogmagazine.com/sites/default/files/images/uploads/ThisisDoge.jpg',
  category: animal_category,
  user: user1
)
birdmeme = Meme.create!(
  title: 'bird meme',
  image_url: 'https://i.chzbgr.com/full/9201253632/hFBA8818F/to-flex-its-muscles-under-the-caption-when-you-open-the-spaghetti-sauce-jar-on-your-first-try',
  category: animal_category,
  user: user2
)

cat2meme = Meme.create!(
  title: 'cat meme 2',
  image_url: 'https://www.dailydot.com/wp-content/uploads/2018/10/olli-the-polite-cat.jpg',
  category: cat_category,
  user: user1
)
dog2meme = Meme.create!(
  title: 'dog meme 2',
  image_url: 'https://moderndogmagazine.com/sites/default/files/images/uploads/ThisisDoge.jpg',
  category: dog_category,
  user: user1
)
bird2meme = Meme.create!(
  title: 'bird meme 2',
  image_url: 'https://i.chzbgr.com/full/9201253632/hFBA8818F/to-flex-its-muscles-under-the-caption-when-you-open-the-spaghetti-sauce-jar-on-your-first-try',
  category: dog_category,
  user: user2
)

user1.memes << catmeme << dogmeme << birdmeme

puts 'martys making a collection!'

user2s_collection = Collection.create!(name: 'martys collection', user: user2)
user2.collections << user2s_collection
cat_meme_collect = Collect.create!(collection: user2.collections.first, meme: catmeme)

puts 'liking some memes'

# Liking cat meme 1
cm_like_1 = Like.create!(user: user1, meme: catmeme)
cm_like_2 = Like.create!(user: user1, meme: catmeme)
cm_like_3 = Like.create!(user: user1, meme: catmeme)
# Liking dog meme 1
dm_like_1 = Like.create!(user: user1, meme: dogmeme)
dm_like_2 = Like.create!(user: user1, meme: dogmeme)
# Liking dog meme 2
dm2_like_1 = Like.create!(user: user1, meme: dog2meme)
dm2_like_2 = Like.create!(user: user1, meme: dog2meme)

catmeme.likes << cm_like_1 << cm_like_2 << cm_like_3
dogmeme.likes << dm_like_1 << dm_like_2
dog2meme.likes << dm2_like_1 << dm2_like_2

puts 'commenting and shit'


cm_comment_1 = Comment.create!(user: user1, meme: catmeme, content: 'nice meme!')
cm_comment_2 = Comment.create!(user: user2, meme: catmeme, content: 'love cat memes!')

dm_comment_1 = Comment.create!(user: user3, meme: dogmeme, content: 'nice doggo meme!')

dm2_comment_1 = Comment.create!(user: user2, meme: dog2meme, content: 'love second doggo meme!')

catmeme.comments << cm_comment_1 << cm_comment_2
dogmeme.comments << dm_comment_1
dog2meme.comments << dm2_comment_1

puts 'lets make some followers!'

UserFollowing.create!(follower: user1, followed_user: user2)
UserFollowing.create!(follower: user3, followed_user: user2)
UserFollowing.create!(follower: user2, followed_user: user3)

CategoryFollowing.create!(follower: user1, category: animal_category)
CategoryFollowing.create!(follower: user2, category: animal_category)

CollectionFollowing.create!(follower: user1, collection: user2s_collection)

puts 'rarifying dem memes'

catmeme.set_rarity
catmeme.save!
dogmeme.set_rarity
dogmeme.save!
birdmeme.set_rarity
birdmeme.save!
cat2meme.set_rarity
cat2meme.save!
dog2meme.set_rarity
dog2meme.save!
bird2meme.set_rarity
bird2meme.save!

puts 'danking them rankings'

user1.init_dank_rank
# user1.save!
user2.init_dank_rank
# user2.save!
user3.init_dank_rank
# user3.save!
user4.init_dank_rank
# user4.save!

