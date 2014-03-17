class Settings::SubscriptionsController < ApplicationController
  before_action :check_center

  def index
    @subscriptions = current_center.subscriptions
  end

  def show
    @subscription = current_center.subscriptions.find(params[:id])
  end
end
