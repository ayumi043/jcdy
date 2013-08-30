class VideosController < ApplicationController
  
  def play_movie
    @movie = Movie.find(params[:id])
    @movie.hits.incr(1)

    respond_to do |format|
      format.html { render :layout => 'movie', :template => "movies/video"}
      format.json { render json: @movie }
    end
  end

end
