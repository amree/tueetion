class HelpController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    @hide_navbar = true
  end
end
