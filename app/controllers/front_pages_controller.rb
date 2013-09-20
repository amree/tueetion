class FrontPagesController < ApplicationController
  before_action :verify_sign_in
  skip_before_filter :authenticate_user!

  def index
  end

  private

  def verify_sign_in
    if current_user
      redirect_to dashboards_index_path
    end
  end
end
