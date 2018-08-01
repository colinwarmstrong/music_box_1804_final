class GenresController < ApplicationController
  before_action :require_admin, only: [:create]

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def show
    @genre = Genre.includes(:songs).find(params[:id])
  end
end
