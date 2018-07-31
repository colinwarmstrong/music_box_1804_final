class GenresController < ApplicationController
  before_action :require_admin, only: [:create]

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def show
    @genre = Genre.includes(:songs).find(params[:id])
  end

  def create
    Genre.create(genre_params)
    redirect_to genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
