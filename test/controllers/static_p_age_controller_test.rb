require "test_helper"

class StaticPAgeControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get '/'
    assert_response :success
    assert_select "title","Home | Ruby on Rails Tutorial Sample App"
  end
  test "should get home" do
    get static_p_age_home_url
    assert_response :success
    assert_select "title", "Home | Ruby on Rails Tutorial Sample App"
  end

  test "should get help" do
    get static_p_age_help_url
    assert_response :success
    assert_select "title", "Help | Ruby on Rails Tutorial Sample App"
  end
end
