class PartiesController < ApplicationController
  def index
  end

  def new
    @viewing_party = Party.new
    @movie = MovieService.return_single_movie #(pass in param for that movie, probably in params)
  end

  def create
    @movie = MovieService.return_single_movie(params[:movie])

    @viewing_party = @movie.parties.new(party_params)
    if @viewing_party.save
      if params[:friends].all? do |viewer_id|
        PartyViewer.create!(party_id: @viewing_party.id, viewer_id: viewer_id)
      end
      redirect_to dashboard_path
    else
      flash[:alert] = "Party not created. Please check that all the information is filled in correctly."
      render :new
    end
  end

  private

  def party_params
    params.permit(:length, :date_of_party, :time_of_party, :host_id) #, :movie)
  end
end
