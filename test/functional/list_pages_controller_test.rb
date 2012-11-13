require 'test_helper'

class ListPagesControllerTest < ActionController::TestCase
  setup do
    @list_page = list_pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:list_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create list_page" do
    assert_difference('ListPage.count') do
      post :create, list_page: { category: @list_page.category, max_value: @list_page.max_value, min_value: @list_page.min_value, page: @list_page.page, page_action: @list_page.page_action, url: @list_page.url }
    end

    assert_redirected_to list_page_path(assigns(:list_page))
  end

  test "should show list_page" do
    get :show, id: @list_page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @list_page
    assert_response :success
  end

  test "should update list_page" do
    put :update, id: @list_page, list_page: { category: @list_page.category, max_value: @list_page.max_value, min_value: @list_page.min_value, page: @list_page.page, page_action: @list_page.page_action, url: @list_page.url }
    assert_redirected_to list_page_path(assigns(:list_page))
  end

  test "should destroy list_page" do
    assert_difference('ListPage.count', -1) do
      delete :destroy, id: @list_page
    end

    assert_redirected_to list_pages_path
  end
end
