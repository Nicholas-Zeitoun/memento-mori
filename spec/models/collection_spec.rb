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
      user_name: "Elton",
      email: "elton.john@rocketman.com",
      password: "password",
      lattitude: "-37.8378816",
      longitude: "144.9736116"
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
    collection = Collection.create!(valid_attributes)
    user = User.new(valid_user_attributes)
    collection.user_id = user.id
    expect(collection.user).to eq(user)
  end

  it "has many memes" do
    should have_many(:memes)
  end

  it "has many followers" do
    should have_many(:followers)
  end
end
