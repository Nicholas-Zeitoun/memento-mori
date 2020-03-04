require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Should have an email address" do
    user = User.new(email: "jeffrey@123.com")
    assert_equal "jeffrey@123.com", user.email
  end

  test "Should have an assigned username" do
    user = User.new(username: "jeffrey123")
    assert_equal "jeffrey123", user.username
  end

  test "Should have a location" do
    user = User.new(location: "South Yarra")
    assert_equal "South Yarra", user.location
  end

  test "Should have a dank rank" do
    user = User.new(dank_rank: DankRank.new(total_score: 10))
    assert_equal 10, user.dank_rank.total_score
  end

end
