class AppController < ApplicationController
  # secure all methods from unauth users
  before_action :authenticate_user!

  def dashboard
  end
end
