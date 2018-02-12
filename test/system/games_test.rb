require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase

  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "h2", count: 10
  end

  test "Going to /new check the invalid english word function" do
    visit new_url
    fill_in "word", with: "l"
    click_on "Play"
    assert_selector "h3", text: "Invalid answer"
  end

  # test "fill the form with a valid English word (that's hard because there is randomness!), click play and get a Congratulations message" do
  #   visit new_url
  #   fill_in "word", with: ????
  #   click_on "Play"
  #   assert_selector "h3", text: "Congratulations"
  #   take_screenshot
  # end

end
