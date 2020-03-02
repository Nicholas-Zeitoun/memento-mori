require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Should have an email address" do
    user = User.new(email: "jeffrey@123.com")
    assert_equal "jeffrey@123.com", user.email
  end

  test "Should have an assigned username" do
    user = User.new(user_name: "jeffrey123")
    assert_equal "jeffrey123", user.user_name
  end

  test "Should have a location Latitude" do
    user = User.new(latitude: "-37.8378816")
    assert_equal "-37.8378816", user.latitude
  end

  test "Should have a location Longitude" do
    user = User.new(logitude: "144.9736116")
    assert_equal "144.9736116", user.longitude
  end
end
