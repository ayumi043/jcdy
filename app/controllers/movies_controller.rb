class MoviesController < ApplicationController

  # caches_action :index, :cache_path => :index_cache_path.to_proc, :expires_in => 0.5.hours

  # layout false
  # layout :resolve_layout
  # layout "movie"


  # GET /movies
  # GET /movies.json
  def index
    # if $redis.get("allmovies")
    #   binding.pry
    #   allmovies = Marshal.load($redis.get 'allmovies')
    # else
    #   binding.pry
    #   allmovies = Movie.all
    #   $redis.set("allmovies", Marshal.dump(allmovies))
    # end
    
    @movies = Movie.all.order_by(:created_at => :desc).page(params[:page]).per(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @movies }
    end
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @movie = Movie.find(params[:id])
    @movie.hits.incr(1)

    respond_to do |format|
      format.html { render :layout => 'movie'}
      format.json { render json: @movie }
    end
  end


  protected

  def resolve_layout
    case action_name
    when "new", "create"
      "application"
    when "show"
      false  
    when "index"
      "application"
    else
      "application"
    end
  end

  def index_cache_path
    if params[:page]
      # user_list_url(params[:user_id, params[:id])
      "#{params[:page]}"
    else
      # list_url(params[:id])
      "0"
    end
  end

end
