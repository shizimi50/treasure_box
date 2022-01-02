require "test_helper"

class ImageControllerTest < ActionDispatch::IntegrationTest
  test "should get upfate" do
    get image_upfate_url
    assert_response :success
  end

  test "should get destroy" do
    get image_destroy_url
    assert_response :success
  end
end
