require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  setup do
    @user = users(:user)
    @center = @user.center
    @ali = students(:ali)

    sign_in @user
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post :create, student: { dob: @ali.dob, email: @ali.email, first_name: @ali.first_name, ic: @ali.ic, last_name: @ali.last_name, phone_number: @ali.phone_number, school_name: @ali.school_name }
    end

    assert_redirected_to student_path(assigns(:student))
    assert_equal @center.id, Student.last.center.id
  end

  test "should show student" do
    get :show, id: @ali

    assert_response :success
    assert_equal @center.id, @ali.center.id
  end

  test "should get edit" do
    get :edit, id: @ali

    assert_response :success
    assert_equal @center.id, @ali.center.id
  end

  test "should update student" do
    patch :update, id: @ali, student: { dob: @ali.dob, email: @ali.email, first_name: @ali.first_name, ic: @ali.ic, last_name: @ali.last_name, phone_number: @ali.phone_number, school_name: @ali.school_name }

    assert_redirected_to student_path(assigns(:student))
    assert_equal @center.id, @ali.center.id
  end

  test "should destroy student" do
    assert_equal @center.id, @ali.center.id

    assert_difference('Student.count', -1) do
      delete :destroy, id: @ali
    end

    assert_redirected_to students_path
  end

  test "should generate bill" do
    assert_difference('Bill.count') do
      post :generate_bill, id: @ali
    end
  end
end
