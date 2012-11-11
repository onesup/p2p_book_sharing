require 'test_helper'

class BookUrlsControllerTest < ActionController::TestCase
  setup do
    @book_url = book_urls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:book_urls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book_url" do
    assert_difference('BookUrl.count') do
      post :create, book_url: { title: @book_url.title, url: @book_url.url }
    end

    assert_redirected_to book_url_path(assigns(:book_url))
  end

  test "should show book_url" do
    get :show, id: @book_url
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book_url
    assert_response :success
  end

  test "should update book_url" do
    put :update, id: @book_url, book_url: { title: @book_url.title, url: @book_url.url }
    assert_redirected_to book_url_path(assigns(:book_url))
  end

  test "should destroy book_url" do
    assert_difference('BookUrl.count', -1) do
      delete :destroy, id: @book_url
    end

    assert_redirected_to book_urls_path
  end
end
