require "test_helper"

class StaticPAgeControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_p_age_home_url
    assert_response :success
  end

  test "should get help" do
    get static_p_age_help_url
    assert_response :success
  end
end
