class HomeController < ApplicationController
  # caches_action :index, :expires_in => 48.hours #, :layout => false
  # caches_page :index#, :gzip => :best_speed

  def index
    # @movies = Movie.order_by(:created_at => :desc).limit(20)

    # @top10_movies = Movie.all.sort_by{|x| x.hits.get() }.reverse.take(10)  # 取出点击率高的前10条
    
    respond_to do |format|
      format.html # index.html.erb
      # format.json { render json: @movies }
    end
  end
end
