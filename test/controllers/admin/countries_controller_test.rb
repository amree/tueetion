require 'test_helper'

class Admin::CountriesControllerTest < ActionController::TestCase
  setup do
    @admin = users(:admin)
    @country = countries(:malaysia)

    sign_in @admin
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:countries)
  end

  test "should get new" do
    get :new

    assert_response :success
  end

  test "should create country" do
    assert_difference('Country.count') do
      post :create, country: { is_active: @country.is_active, name: @country.name, sms_rate: @country.sms_rate, calling_code: @country.calling_code }
    end

    assert_redirected_to admin_country_path(assigns(:country))
  end

  test "should show country" do
    get :show, id: @country
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @country
    assert_response :success
  end

  test "should update country" do
    patch :update, id: @country, country: { is_active: @country.is_active, name: @country.name, sms_rate: @country.sms_rate, calling_code: @country.calling_code }
    assert_redirected_to admin_country_path(assigns(:country))
  end

  test "should destroy country" do
    assert_difference('Country.count', -1) do
      delete :destroy, id: @country
    end

    assert_redirected_to admin_countries_path
  end
end
