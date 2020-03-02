require 'rails_helper'

RSpec.describe "Meme", :type => :meme do
  # Hash for valid user attributes to test build user
  let(:valid_attributes) do
    {
      title: "HTML Doge",
      rarity: 10
    }
  end
  # Hash for valid user attributes to test build user
  let(:valid_user_attributes) do
    {
      user_name: "Elton",
      email: "elton.john@rocketman.com",
      password: "password",
      lattitude: "-37.8378816",
      longitude: "144.9736116"
    }
  end

  it "has a title" do
    meme = Meme.new(title: "HTML Doge")
    expect(meme.title).to eq("HTML Doge")
  end

  # Belongs to a user
  it "belongs to a user" do
    meme = Meme.create!(valid_attributes)
    user = User.new(valid_user_attributes)
    meme.user_id = user.id
    expect(meme.user).to eq(user)
  end

  # Belongs to a category
  it "belongs to a category" do
    meme = Meme.create!(valid_attributes)
    category = Category.new(name: "Doge Memes")
    meme.category_id = category.id
    expect(meme.category).to eq(category)
  end

  # Belongs to a collection
  it "belongs to a collection" do
    meme = Meme.create!(valid_attributes)
    collection = Collection.new(name: "My Doge Collection")
    meme.collection_id = collection.id
    expect(meme.collection).to eq(collection)
  end

  it "has a rarity" do
    meme = Meme.new(valid_attributes)
    expect(meme.rarity).to eq(10)
  end

  it "has many likes" do
    should have_many(:likes)
  end

  it "has many comments" do
    should have_many(:comments)
  end
end
