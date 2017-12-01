class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])    
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      flash[:notice] = "restaurant was successfully created"
      redirect_to admin_restaurant_path
    else
      flash.now[:alert] = "restaurant was failed to create"
      render :action => :new
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :tel, :address, :opening_hours, :description)
  end
end
