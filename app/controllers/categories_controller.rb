class CategoriesController < ApplicationController

  # layout false

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    # binding.pry
    @category = Category.find(params[:id])
    @movies = @category.movies.order_by(:created_at => :desc).page(params[:page]).per(20)
    



    # @top10_movies ||= Rails.cache.fetch(@category.id, :expires_in => 24.hours) { 
    #   @category.movies.sort_by{ |x| x.hits.get() }.reverse.take(10).map{|x|[x.name,x.hits.get(),x.id]}
    # }
    # <div class="charts">
    #   <div class="mod-tit">
    #     <h4>
    #       <a target="_blank">热播<%= @category.name %>排行榜</a>
    #     </h4>
    #   </div>
    #   <ul class="charts-tab cfix">
    #     <li data-key="phb_tv_total_10_simple">
    #       <a target="_blank">全部</a>
    #     </li>
    #   </ul>

    #   <div class="charts-con cfix">
    #     <ul class="clist cfix clistL">
    #       <% @top10_movies.each do |movie| %>
    #         <li>
    #           <%= link_to movie[0], "movies/#{movie[2]}", {:title => movie[0]} %>
    #           &nbsp;&nbsp;<a class="bcount" title="播放数"><%= movie[1] %></a>
    #         </li>
    #       <% end %>
    #     </ul>
    #   </div>
    # </div>

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  def comedy
    binding.pry
    @category = Category.find("513b88bfb1cc7540d2000003")
    @movies = @category.movies
    render "show"
  end

end
