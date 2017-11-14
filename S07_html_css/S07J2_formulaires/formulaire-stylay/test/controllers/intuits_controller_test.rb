require 'test_helper'

class IntuitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get intuits_index_url
    assert_response :success
  end

  test "should get private" do
    get intuits_private_url
    assert_response :success
  end

end
