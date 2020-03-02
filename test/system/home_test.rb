require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  # [...]
  test "Visits the home page" do
    visit "/"
    assert_selector "h1", text: "Pages#home"
  end

end
