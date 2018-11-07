require 'test_helper'

class TimecardsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get timecards_new_url
    assert_response :success
  end

end
