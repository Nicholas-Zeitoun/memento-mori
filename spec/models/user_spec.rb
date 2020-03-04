require 'rails_helper'

RSpec.describe "User", :type => :user do
  # Hash for valid user attributes to test build user
  let(:valid_attributes) do
    {
      username: "Elton",
      email: "elton.john@rocketman.com",
      password: "password"
    }
  end
  # Hash for valid dank_rank attributes to test user
  let(:valid_dank_rank) do
    {
      total_score: "150",
      collection_score: "50",
      engagement_score: "50",
      creation_score: "50"
    }
  end

  it "has a username" do
    user = User.new(username: "jeffrey123")
    expect(user.username).to eq("jeffrey123")
  end

  it "username cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:username)
    user = User.new(attributes)
    expect(user).not_to be_valid
  end

  it "has a location" do
    user = User.new(location: "South Yarra")
    expect(user.location).to eq("South Yarra")
  end

  it "has a dank_rank" do
    user = User.new(valid_attributes)
    expect(user).to respond_to(:dank_rank)
  end

  it "has many memes" do
    user = User.new(valid_attributes)
    expect(user).to respond_to(:memes)
    expect(user.memes.count).to eq(0)
  end

  it "has many categories" do
    user = User.new(valid_attributes)
    expect(user).to respond_to(:categories)
    expect(user.categories.count).to eq(0)
  end

  it "can follow categories" do
    user = User.new(valid_attributes)
    expect(user).to respond_to(:followed_categories)
    expect(user.followed_collections.count).to eq(0)
  end

  it "has many collections" do
    user = User.new(valid_attributes)
    expect(user).to respond_to(:collections)
    expect(user.collections.count).to eq(0)
  end

  it "can follow collections" do
    user = User.new(valid_attributes)
    expect(user).to respond_to(:followed_collections)
    expect(user.followed_collections.count).to eq(0)
  end

  it "has many followers" do
    user = User.new(valid_attributes)
    expect(user).to respond_to(:followers)
    expect(user.followers.count).to eq(0)
  end

  it "has many followings" do
    user = User.new(valid_attributes)
    expect(user).to respond_to(:followed_users)
    expect(user.followed_users.count).to eq(0)
  end
end
