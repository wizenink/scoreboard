require "test_helper"

class MatchesControllerTest < ActionDispatch::IntegrationTest

  test "should get show" do
    test_match = matches(:one)
    get match_path(test_match.id), headers: http_login
    #get matches_path
    assert_response :success
  end

  test "should get index" do
    get matches_path, headers: http_login
    assert_response :success
  end

end
