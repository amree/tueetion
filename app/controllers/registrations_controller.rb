class RegistrationsController < Devise::RegistrationsController
  def create
    super
    AdminMailer.new_user(@user).deliver unless @user.invalid?
  end
end
