require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  setup do
    @user = users(:user)
    @center = @user.center
    @student = students(:student)

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
      post :create, student: { dob: @student.dob, email: @student.email, first_name: @student.first_name, ic: @student.ic, last_name: @student.last_name, phone: @student.phone, school_name: @student.school_name }
    end

    assert_redirected_to student_path(assigns(:student))
    assert_equal @center.id, Student.last.center.id
  end

  test "should show student" do
    get :show, id: @student

    assert_response :success
    assert_equal @center.id, @student.center.id
  end

  test "should get edit" do
    get :edit, id: @student

    assert_response :success
    assert_equal @center.id, @student.center.id
  end

  test "should update student" do
    patch :update, id: @student, student: { dob: @student.dob, email: @student.email, first_name: @student.first_name, ic: @student.ic, last_name: @student.last_name, phone: @student.phone, school_name: @student.school_name }

    assert_redirected_to student_path(assigns(:student))
    assert_equal @center.id, @student.center.id
  end

  test "should destroy student" do
    assert_equal @center.id, @student.center.id

    assert_difference('Student.count', -1) do
      delete :destroy, id: @student
    end

    assert_redirected_to students_path
  end

  test "should forward to center if it it's not set yet" do
    sign_out users(:user)
    sign_in users(:user_no_center)

    get :index
    assert_redirected_to centers_path

    post :create
    assert_redirected_to centers_path

    get :show, id: @student
    assert_redirected_to centers_path

    get :edit, id: @student
    assert_redirected_to centers_path

    patch :update, id: @student
    assert_redirected_to centers_path

    delete :destroy, id: @student
    assert_redirected_to centers_path
  end
end
