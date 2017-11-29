class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_user!

  def index
  end
end
