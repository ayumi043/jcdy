require 'test_helper'

class KuaibovideosControllerTest < ActionController::TestCase
  setup do
    @kuaibovideo = kuaibovideos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kuaibovideos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kuaibovideo" do
    assert_difference('Kuaibovideo.count') do
      post :create, kuaibovideo: { link: @kuaibovideo.link, name: @kuaibovideo.name }
    end

    assert_redirected_to kuaibovideo_path(assigns(:kuaibovideo))
  end

  test "should show kuaibovideo" do
    get :show, id: @kuaibovideo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kuaibovideo
    assert_response :success
  end

  test "should update kuaibovideo" do
    put :update, id: @kuaibovideo, kuaibovideo: { link: @kuaibovideo.link, name: @kuaibovideo.name }
    assert_redirected_to kuaibovideo_path(assigns(:kuaibovideo))
  end

  test "should destroy kuaibovideo" do
    assert_difference('Kuaibovideo.count', -1) do
      delete :destroy, id: @kuaibovideo
    end

    assert_redirected_to kuaibovideos_path
  end
end
