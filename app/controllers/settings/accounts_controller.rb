class Settings::AccountsController < ApplicationController
  before_action :check_center
  before_action :set_user

  def edit
    @user= current_user
  end

  def update
    @user = User.find(current_user.id)

    if @user.update_without_password(user_params_without_password)
      redirect_to edit_settings_accounts_path, notice: "Account was successfully updated."
    else
      render "edit"
    end
  end

  def edit_password
    @user = current_user
  end

  def update_password
    @user = User.find(current_user.id)

    if @user.update_with_password(user_params)
      sign_in @user, bypass: true
      redirect_to edit_password_settings_accounts_path, notice: "Password was successfully updated."
    else
      render :edit_password
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params_without_password
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
