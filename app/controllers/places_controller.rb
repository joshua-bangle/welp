class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]


  def index
    @places = Place.order(:name).page(params[:page])
  end



  def create
    @place = current_user.places.create(place_params)
    redirect_to root_path
  end

  def show
    @place = Place.find(params[:id])
  end

  def edit
    @place = Place.find(params[:id])
  end

  def update
    @place = Place.find(params[:id])
    @place.update_attributes(place_params)
    redirect_to place_path(params[:id]) #I wanted it to link back to the edited place, not to the full index. How else will the user see if their edit went through easily?
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :address)
  end

end
