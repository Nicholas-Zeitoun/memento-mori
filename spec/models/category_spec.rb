require 'rails_helper'

RSpec.describe "Category", :type => :category do
  # Hash for valid user attributes to test build user
  let(:valid_attributes) do
    {
      name: "Doge"
    }
  end

  it "has a name" do
    category = Category.new(valid_attributes)
    expect(category.name).to eq("Doge")
  end

  it "category name cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:name)
    category = Category.new(attributes)
    expect(category).not_to be_valid
  end

  it "has many memes" do
    category = Category.new(valid_attributes)
    expect(category).to respond_to(:memes)
    expect(category.memes.count).to eq(0)
  end

  it "has many followers" do
    should have_many(:category_followers)
  end
end
