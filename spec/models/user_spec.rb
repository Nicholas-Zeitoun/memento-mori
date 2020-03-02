require 'rails_helper'

RSpec.describe "User", :type => :user do
  # Hash for valid user attributes to test build user
  let(:valid_attributes) do
    {
      user_name: "Elton",
      email: "elton.john@rocketman.com",
      password: "password",
      lattitude: "-37.8378816",
      longitude: "144.9736116"
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

  it "has a user_name" do
    user = User.new(user_name: "jeffrey123")
    expect(user.user_name).to eq("jeffrey123")
  end

  it "user_name cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:user_name)
    user = User.new(attributes)
    expect(user).not_to be_valid
  end

  it "has a location lattitude" do
    user = User.new(lattitude: "-37.8378816")
    expect(user.lattitude).to eq("-37.8378816")
  end

  it "has a location longitude" do
    user = User.new(lattitude: "144.9736116")
    expect(user.lattitude).to eq("144.9736116")
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

  it "has many followers" do
    user = User.new(valid_attributes)
    expect(user).to respond_to(:followees)
    expect(user.followees.count).to eq(0)
  end

  it "has many followings" do
    user = User.new(valid_attributes)
    expect(user).to respond_to(:followings)
    expect(user.followings.count).to eq(0)
  end
end
