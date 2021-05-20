class MoviesController < ApplicationController
  def index

    @movie_list = if params[:search_text].present?
                    MovieService.list_movies_by_keyword(params[:search_text])
                  else
                    MovieService.get_top_rated_movies
                  end
  end

  def show

    @movie = MovieService.return_single_movie(params[:id])
    @reviews = MovieService.return_single_movie_review(params[:id])
    @cast = MovieService.return_single_movie_cast(params[:id])
  end

  def movies_params
    params.require(:movie).permit(:search_query, :search_text, :id)
  end
end
