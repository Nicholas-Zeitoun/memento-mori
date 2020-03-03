require 'test_helper'

class CollectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get collections_show_url
    assert_response :success
  end

  test "should get new" do
    get collections_new_url
    assert_response :success
  end

  test "should get create" do
    get collections_create_url
    assert_response :success
  end

  test "should get edit" do
    get collections_edit_url
    assert_response :success
  end

  test "should get update" do
    get collections_update_url
    assert_response :success
  end

  test "should get delete" do
    get collections_delete_url
    assert_response :success
  end

end
