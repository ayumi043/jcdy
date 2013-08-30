class KuaibovideosController < ApplicationController
  # GET /kuaibovideos
  # GET /kuaibovideos.json
  def index
    @kuaibovideos = Kuaibovideo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @kuaibovideos }
    end
  end

  # GET /kuaibovideos/1
  # GET /kuaibovideos/1.json
  def show
    @kuaibovideo = Kuaibovideo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @kuaibovideo }
    end
  end

  # GET /kuaibovideos/new
  # GET /kuaibovideos/new.json
  def new
    @kuaibovideo = Kuaibovideo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @kuaibovideo }
    end
  end

  # GET /kuaibovideos/1/edit
  def edit
    @kuaibovideo = Kuaibovideo.find(params[:id])
  end

  # POST /kuaibovideos
  # POST /kuaibovideos.json
  def create
    binding.pry

    @movie = Movie.find(params[:movie_id])
    @kuaibovideo = @movie.kuaibovideos.create!(params[:kuaibovideo])
    redirect_to @movie, :notice => "Comment created!"

    # @kuaibovideo = Kuaibovideo.new(params[:kuaibovideo])

    # respond_to do |format|
    #   if @kuaibovideo.save
    #     format.html { redirect_to @kuaibovideo, notice: 'Kuaibovideo was successfully created.' }
    #     format.json { render json: @kuaibovideo, status: :created, location: @kuaibovideo }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @kuaibovideo.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PUT /kuaibovideos/1
  # PUT /kuaibovideos/1.json
  def update
    @kuaibovideo = Kuaibovideo.find(params[:id])

    respond_to do |format|
      if @kuaibovideo.update_attributes(params[:kuaibovideo])
        format.html { redirect_to @kuaibovideo, notice: 'Kuaibovideo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @kuaibovideo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kuaibovideos/1
  # DELETE /kuaibovideos/1.json
  def destroy
    @kuaibovideo = Kuaibovideo.find(params[:id])
    @kuaibovideo.destroy

    respond_to do |format|
      format.html { redirect_to kuaibovideos_url }
      format.json { head :no_content }
    end
  end
end
