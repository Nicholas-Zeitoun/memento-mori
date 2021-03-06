require 'rails_helper'
require 'byebug'

RSpec.describe "Meme", :type => :meme do
  # Hash for valid user attributes to test build user
  let(:valid_attributes) do
    {
      title: "HTML Doge",
      rarity: Rarity.new(total_score: 10)
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

  it "has a title" do
    meme = Meme.new(title: "HTML Doge")
    expect(meme.title).to eq("HTML Doge")
  end

  # Belongs to a user
  it "belongs to a user" do
    user = User.create!(valid_user_attributes)
    meme = Meme.new(valid_attributes)
    meme.user_id = user.id
    expect(meme.user).to eq(user)
  end

  # Belongs to a category
  it "belongs to a category" do
    user = User.create!(valid_user_attributes)
    category = Category.create!(name: "Doge Memes", user: user)
    meme = Meme.new(valid_attributes)
    meme.category_id = category.id
    expect(meme.category).to eq(category)
  end

  it "can be collected" do
    meme = Meme.new(valid_attributes)
    expect(meme).to respond_to(:collects)
    expect(meme.collects.count).to eq(0)
  end

  # Belongs to a collection
  it "Can belong to a collection" do
    user = User.create!(valid_user_attributes)
    category = Category.create!(name: "Doge Memes", user: user)
    meme = Meme.new(valid_attributes)
    collection = Collection.create!(name: "My Doge Collection", user: user)
    collect = Collect.create!(collection: collection, meme: meme)
    # meme.collect_id = collect.id
    # expect(meme.collect).to eq(collect)
    expect(meme).to respond_to(:collections)
    expect(meme.collections.count).to eq(0)
  end

  it "has a rarity" do
    meme = Meme.new(valid_attributes)
    expect(meme).to respond_to(:rarity)
    expect(meme.rarity.total_score).to eq(10)
  end

  it "has many likes" do
    meme = Meme.new(valid_attributes)
    expect(meme).to respond_to(:likes)
    expect(meme.likes.count).to eq(0)
  end

  it "has many comments" do
    meme = Meme.new(valid_attributes)
    expect(meme).to respond_to(:comments)
    expect(meme.likes.count).to eq(0)
  end
end
