class SitemapsController < ApplicationController
 	# caches_page :show, :expires_in => 48.hours

  def show
    @movies = Movie.all.order_by(:created_at => :desc).limit(10000)
  end
end
