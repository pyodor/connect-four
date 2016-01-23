require 'test_helper'

class ConnectFoursControllerTest < ActionController::TestCase
  setup do
    @connect_four = connect_fours(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:connect_fours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create connect_four" do
    assert_difference('ConnectFour.count') do
      post :create, connect_four: {  }
    end

    assert_redirected_to connect_four_path(assigns(:connect_four))
  end

  test "should show connect_four" do
    get :show, id: @connect_four
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @connect_four
    assert_response :success
  end

  test "should update connect_four" do
    patch :update, id: @connect_four, connect_four: {  }
    assert_redirected_to connect_four_path(assigns(:connect_four))
  end

  test "should destroy connect_four" do
    assert_difference('ConnectFour.count', -1) do
      delete :destroy, id: @connect_four
    end

    assert_redirected_to connect_fours_path
  end
end
