class SearchController < ApplicationController
  
  def index
    tmp = Movie.any_of({:name => /#{params[:q]}/}, {:actor => /#{params[:q]}/}).desc(:created_at)
                   
    @movies = tmp.page(params[:page]).per(20)  # or查询
    @count = tmp.count

    render :template => "movies/index"            
  end

  def find_movie_by_pinyin
    return nil if params[:q].blank?
    if /[a-z]/ =~ arams[:id]
      @movies = Movie.all.select{|i| Pinyin.t(i[:name])[0] == params[:q] }
    end    
  end

  def find_movie_by_name
    # return nil if params[:q].blank?
    @movies = Movie.where(:name => /#{params[:q]}/).desc(:created_at).page(params[:page]).per(20)

    @count = Movie.where(:name => /#{params[:q]}/).count

    render :template => "movies/index"
    # render :text => "Hello"
  end

  def find_movie_by_actor
    # return nil if params[:q].blank?
    @movies = Movie.where(:actor => /#{params[:q]}/).desc(:created_at).page(params[:page]).per(20)

    # @count ||= Rails.cache.fetch("actor-#{params[:q]}", :expires_in => 30.minute) { 
    #   Movie.where(:actor => /#{params[:q]}/).count
    # }

    @count = Movie.where(:actor => /#{params[:q]}/).count

    render :template => "movies/index"
  end

  def find_movie_by_hits_top_10
    # @movies = Movie.all.max_by{|x| x.hits.get() }
    @movies = Movie.all.sort_by{|x| x.hits.get() }.reverse.take(10)  # 取出点击率高的前10条
  end
end
