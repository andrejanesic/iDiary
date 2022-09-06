class AppController < ApplicationController
  layout 'container'

  # secure all methods from unauth users
  before_action :authenticate_user!

  def dashboard; end
end
