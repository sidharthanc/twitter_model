require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get rake" do
    get :rake
    assert_response :success
  end

  test "should get routes" do
    get :routes
    assert_response :success
  end

end
