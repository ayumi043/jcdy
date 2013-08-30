require 'test_helper'

class BaiduvideosControllerTest < ActionController::TestCase
  setup do
    @baiduvideo = baiduvideos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:baiduvideos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create baiduvideo" do
    assert_difference('Baiduvideo.count') do
      post :create, baiduvideo: { link: @baiduvideo.link, name: @baiduvideo.name }
    end

    assert_redirected_to baiduvideo_path(assigns(:baiduvideo))
  end

  test "should show baiduvideo" do
    get :show, id: @baiduvideo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @baiduvideo
    assert_response :success
  end

  test "should update baiduvideo" do
    put :update, id: @baiduvideo, baiduvideo: { link: @baiduvideo.link, name: @baiduvideo.name }
    assert_redirected_to baiduvideo_path(assigns(:baiduvideo))
  end

  test "should destroy baiduvideo" do
    assert_difference('Baiduvideo.count', -1) do
      delete :destroy, id: @baiduvideo
    end

    assert_redirected_to baiduvideos_path
  end
end
