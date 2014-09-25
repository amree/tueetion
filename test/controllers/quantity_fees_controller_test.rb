require 'test_helper'

class QuantityFeesControllerTest < ActionController::TestCase
  setup do
    @user = users(:user)
    @quantity_fee = quantity_fees(:bm_quantity_fee)

    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quantity_fees)
  end

  test "should get new" do
    get :new

    assert_response :success
    assert_not_nil assigns(:subjects_for_select)
  end

  test "should redirect to subject's path when no subject defined'" do
    # TODO: Mock!
    @user.center.subjects.each do |subject|
      subject.delete
    end

    get :new

    assert_redirected_to subjects_path
  end

  test "should create quantity_fee" do
    assert_difference('QuantityFee.count') do
      post :create, quantity_fee: { name: "Nama", is_active: @quantity_fee.is_active, price: @quantity_fee.price, subject_id: @quantity_fee.subject_id }
    end

    assert_redirected_to quantity_fee_path(assigns(:quantity_fee))
  end

  test "should show quantity_fee" do
    get :show, id: @quantity_fee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quantity_fee

    assert_response :success
    assert_not_nil assigns(:subjects_for_select)
  end

  test "should update quantity_fee" do
    patch :update, id: @quantity_fee, quantity_fee: { name: "Nama", is_active: @quantity_fee.is_active, price: @quantity_fee.price, subject_id: @quantity_fee.subject_id }
    assert_redirected_to quantity_fee_path(assigns(:quantity_fee))
  end

  test "should destroy quantity_fee" do
    assert_difference('QuantityFee.count', -1) do
      delete :destroy, id: @quantity_fee
    end

    assert_redirected_to quantity_fees_path
  end
end
