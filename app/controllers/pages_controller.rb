class PagesController < ApplicationController
  def home
    @coordinates = Coordinate.new
  end
end
