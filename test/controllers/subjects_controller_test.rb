require 'test_helper'

class SubjectsControllerTest < ActionController::TestCase
  setup do
    @subject = subjects(:bm)

    sign_in users(:user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subjects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subject" do
    assert_difference('Subject.count') do
      post :create, subject: { center_id: @subject.center_id, is_active: @subject.is_active, name: @subject.name }
    end

    assert_redirected_to subject_path(assigns(:subject))
  end

  test "should show subject" do
    get :show, id: @subject
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subject
    assert_response :success
  end

  test "should update subject" do
    patch :update, id: @subject, subject: { center_id: @subject.center_id, is_active: @subject.is_active, name: @subject.name }
    assert_redirected_to subject_path(assigns(:subject))
  end

  test "should destroy subject" do
    assert_difference('Subject.count', -1) do
      delete :destroy, id: @subject
    end

    assert_redirected_to subjects_path
  end

  test "should forward to center if it it's not set yet" do
    sign_out users(:user)
    sign_in users(:user_no_center)

    get :index
    assert_redirected_to centers_path

    post :create
    assert_redirected_to centers_path

    get :show, id: @subject
    assert_redirected_to centers_path

    get :edit, id: @subject
    assert_redirected_to centers_path

    patch :update, id: @subject
    assert_redirected_to centers_path

    delete :destroy, id: @subject
    assert_redirected_to centers_path
  end
end
