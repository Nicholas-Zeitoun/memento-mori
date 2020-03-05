require "open-uri"

DankRank.delete_all
Meme.delete_all
Category.delete_all
User.delete_all

puts 'making shiny happy people'

user_seed_file = Rails.root.join('db', 'seeds', 'users.yml')
user_config = YAML::load_file(user_seed_file)
user_config.each do |user|
  new_user = User.new(user.last)
  file = URI.open(new_user.avatar_url)
  new_user.avatar.attach(io: file, filename: "#{new_user.username}.png", content_type: 'image/png')
  new_user.save!
end

puts 'making dem categories'

category_seed_file = Rails.root.join('db', 'seeds', 'categories.yml')
category_config = YAML::load_file(category_seed_file)
category_config.each do |category|
  category_creator = User.where(username: category.last["user"])[0]
  new_category = Category.new(
    user: category_creator,
    name: category.last["name"]
  )
  new_category.save!
end

puts 'Danking those memes'

meme_seed_file = Rails.root.join('db', 'seeds', 'memes.yml')
meme_config = YAML::load_file(meme_seed_file)
meme_config[:users].each do |user|
  puts user[:username]
  unless user[:categories].nil?
    user[:categories].each do |category|
      puts category[:category_name]
      unless category[:memes].nil?
        category[:memes].each do |meme|
          meme_owner = User.where(username: user[:username])[0]
          meme_category = Category.where(name: category[:category_name])[0]
          # p meme[memes]
          new_meme = Meme.new(
            title: meme[:title],
            image_url: meme[:image_url],
            user: meme_owner,
            category: meme_category
          )
          file = URI.open(new_meme.image_url)
          new_meme.image.attach(io: file, filename: "#{new_meme.title}.png", content_type: 'image/png')
          new_meme.save!
        end
      end
    end
  end
end

users = User.all
users.each do |user|
  user.init_dank_rank
  user.set_dank_rank
end
# need to iterate thorugh all users at the end and init and set dank ranks

