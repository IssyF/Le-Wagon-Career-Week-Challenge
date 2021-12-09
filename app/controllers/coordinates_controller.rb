require 'json'
require 'open-uri'


class CoordinatesController < ApplicationController

  def new
    @coordinates = Coordinate.new
  end

  def create
    @coordinates = Coordinate.new(coordinate_params)
    if @coordinates.save
      redirect_to coordinate_path(@coordinates)
    else
      render :new
    end
  end

  def show
    @coordinates = Coordinate.last
    @longitude = @coordinates.longitude
    @latitude = @coordinates.latitude
    # longitude = -0.176449
    # latitude = 51.497208

    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=#{@longitude},#{@latitude}&access_token=pk.eyJ1IjoiaXNzeWYiLCJhIjoiY2t3ejVmZndkMHZhYzJvcDg4cG1nNDVyNSJ9.-hT50idJcEEsGZPD51_s9g"
    location_serialized = URI.open(url).read
    museums = JSON.parse(location_serialized)["features"]
    @postcodes = museums.map { |museum| museum["context"][1]["text"] }
    @names = museums.map do |museum|
      museum_name_array = []
      museum_name_array << museum["text"]
    end
    count = (0..4).to_a
    @museum_results = {}
    count.each do |num|
      @museum_results[@postcodes[num]] = @names[num]
    end
  end

  private

  def coordinate_params
    params.require(:coordinate).permit(:longitude, :latitude)
  end

end
