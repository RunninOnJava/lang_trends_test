require 'test_helper'

class DoWorkControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Programming Language Trends Across Major Cities"
  end
end
