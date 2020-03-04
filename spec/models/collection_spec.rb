require 'rails_helper'

RSpec.describe "Collection", :type => :collection do
  # Hash for valid user attributes to test build user
  let(:valid_attributes) do
    {
      name: "My Doges",
    }
  end
  # Hash for valid user attributes to test build user
  let(:valid_user_attributes) do
    {
      username: "Elton",
      email: "elton.john@rocketman.com",
      password: "password"
    }
  end

  #hash for valid meme
  let(:valid_meme_attributes) do
    {
      title: 'dog meme',
      image_url: 'catmeme.jpg',
    }
  end

  it "has a name" do
    collection = Collection.new(valid_attributes)
    expect(collection.name).to eq("My Doges")
  end

  it "collection name cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:name)
    collection = Collection.new(attributes)
    expect(collection).not_to be_valid
  end

  # Belongs to a user
  it "belongs to a user" do
    user = User.create!(valid_user_attributes)
    collection = Collection.new(valid_attributes)
    collection.user_id = user.id
    expect(collection.user).to eq(user)
  end

  it "has many memes" do
    user = User.create!(valid_user_attributes)
    category = Category.create!(user: user, name: 'animal category')
    meme = Meme.new(title: 'doge meme', image_url: 'www', category: category, user: user)
    collection = Collection.create!(name: 'doge memes collection', user: user)
    collect = Collect.create!(collection: collection, meme: meme)
    expect(collection).to respond_to(:memes)
    expect(collection.memes.count).to eq(1)
  end

  it "has many followers" do
    collection = Collection.new(valid_attributes)
    expect(collection).to respond_to(:followers)
    expect(collection.followers.count).to eq(0)
  end
end
