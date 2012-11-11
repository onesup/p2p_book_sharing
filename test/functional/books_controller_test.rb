require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  setup do
    @book = books(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post :create, book: { authors: @book.authors, description: @book.description, foreign_titlefirst_category: @book.foreign_titlefirst_category, index_page: @book.index_page, isbn10: @book.isbn10, isbn13: @book.isbn13, language: @book.language, last_page: @book.last_page, main_author: @book.main_author, price: @book.price, published_at: @book.published_at, publisher: @book.publisher, reviewed: @book.reviewed, second_category: @book.second_category, series: @book.series, size: @book.size, title: @book.title, url: @book.url }
    end

    assert_redirected_to book_path(assigns(:book))
  end

  test "should show book" do
    get :show, id: @book
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book
    assert_response :success
  end

  test "should update book" do
    put :update, id: @book, book: { authors: @book.authors, description: @book.description, foreign_titlefirst_category: @book.foreign_titlefirst_category, index_page: @book.index_page, isbn10: @book.isbn10, isbn13: @book.isbn13, language: @book.language, last_page: @book.last_page, main_author: @book.main_author, price: @book.price, published_at: @book.published_at, publisher: @book.publisher, reviewed: @book.reviewed, second_category: @book.second_category, series: @book.series, size: @book.size, title: @book.title, url: @book.url }
    assert_redirected_to book_path(assigns(:book))
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete :destroy, id: @book
    end

    assert_redirected_to books_path
  end
end
