require 'test_helper'

class DealsControllerTest < ActionController::TestCase
  setup do
    @deal = deals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deal" do
    assert_difference('Deal.count') do
      post :create, deal: { buyer_id: @deal.buyer_id, collection_id: @deal.collection_id, memo: @deal.memo, mobile: @deal.mobile, point: @deal.point, seller_id: @deal.seller_id, status: @deal.status, village_id: @deal.village_id }
    end

    assert_redirected_to deal_path(assigns(:deal))
  end

  test "should show deal" do
    get :show, id: @deal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deal
    assert_response :success
  end

  test "should update deal" do
    put :update, id: @deal, deal: { buyer_id: @deal.buyer_id, collection_id: @deal.collection_id, memo: @deal.memo, mobile: @deal.mobile, point: @deal.point, seller_id: @deal.seller_id, status: @deal.status, village_id: @deal.village_id }
    assert_redirected_to deal_path(assigns(:deal))
  end

  test "should destroy deal" do
    assert_difference('Deal.count', -1) do
      delete :destroy, id: @deal
    end

    assert_redirected_to deals_path
  end
end
