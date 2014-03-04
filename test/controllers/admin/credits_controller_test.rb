require 'test_helper'

class Admin::CreditsControllerTest < ActionController::TestCase
  setup do
    @admin = users(:admin)
    @credit = credits(:credit_pakar)
    @transaction = transactions(:credit_payment)

    sign_in @admin
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:credits)
  end

  test "should get new" do
    get :new

    assert_response :success
  end

  test "should create credit" do
    credit = @credit.dup.attributes.except(:id, :created_at, :updated_at)
    transaction = @transaction.dup.attributes.except(:id, :created_at, :updated_at)

    attributes = { credit: credit.merge(transactions_attributes: transaction) }

    assert_difference("Transaction.count") do
      assert_difference("Credit.count") do
        post :create, attributes
      end
    end

    assert_redirected_to admin_credit_path(Credit.last)
  end

  test "should get edit" do
    get :edit, id: @credit

    assert_response :success
  end

  test "should update credit" do
    patch :update, id: @credit, credit: @credit.attributes

    assert_redirected_to admin_credit_path(assigns(:credit))
  end

  test "should destroy credit and related transaction" do
    assert_difference("Transaction.count", -1) do
      assert_difference("Credit.count", -1) do
        delete :destroy, id: @credit
      end
    end
  end

  test "should show credit" do
    get :show, id: @credit

    assert_response :success
  end
end
