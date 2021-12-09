class CoordinatesController < ApplicationController

  def new
    @coordinates = Coordinate.new
  end

  def create
    @coordinates = Coordinate.new(coordinate_params)
    if @coordinates.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def coordinate_params
    params.require(:coordinate).permit(:longitude, :latitude)
  end

end
