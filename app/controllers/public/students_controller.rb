class Public::StudentsController < ApplicationController
  skip_before_filter :authenticate_user!

  def show
    @student = Student.find_by_public_key(params[:id])
  end
end
