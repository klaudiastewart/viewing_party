class PartiesController < ApplicationController
  def index
  end

  def new
    @viewing_party = Party.new
    @movie = MovieService.return_single_movie(params[:movie_id])
  end

  def create
    @api_movie = MovieService.return_single_movie(params[:movie])
    @movie = Movie.create!(title: "#{@api_movie[:original_title]}", api_id: "#{params[:movie]}")
    @viewing_party = @movie.parties.create!(party_params)
    if @viewing_party.save && !params[:friends].nil? && params[:length].to_i >= @api_movie[:runtime]
      params[:friends].each do |viewer_id|
        PartyViewer.create(party_id: @viewing_party.id, viewer_id: viewer_id)
      end
      redirect_to dashboard_index_path
    else
      flash[:alert] = "Party not created. Please check that you've added friends."
      redirect_to "/parties/new?movie_id=#{params[:movie]}"
    end
  end

  private

  def party_params
    params.permit(:length, :date_of_party, :time_of_party, :host_id)
  end
end
