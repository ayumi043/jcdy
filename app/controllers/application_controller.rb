class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :laod_category, :load_top_searches, :rewrite_url

  protected

  def rewrite_url
    # if request.host = "www.ckm888.com"
    #   redirect_to("#{request.protocol}#{request.path}", :status => 301)
    # end  


    # binding.pry

    # if request.host == "localhost"
    #   redirect_to("http://www.jcdy.co#{request.path}", :status => 301)
    # end 

  end  

  def laod_category
    # @categories ||= Category.order_by(:sortid => :asc)
    # @top_searches ||= Topsearch.all

    @categories ||= Rails.cache.fetch('categories') { 
      Category.all.sort_by{|x|x.sortid.to_i}.entries
    }
    @categories
  end

  def load_top_searches
    @top_searches ||= Rails.cache.fetch('top_searches', :expires_in => 48.hours) { 
      Topsearch.all.entries
    }
    @top_searches
  end

end
