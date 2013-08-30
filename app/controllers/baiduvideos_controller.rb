class BaiduvideosController < ApplicationController
  
  # GET /baiduvideos
  # GET /baiduvideos.json
  def index
    @baiduvideos = Baiduvideo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @baiduvideos }
    end
  end

  # GET /baiduvideos/1
  # GET /baiduvideos/1.json
  def show
    @baiduvideo = Baiduvideo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @baiduvideo }
    end
  end

  # GET /baiduvideos/new
  # GET /baiduvideos/new.json
  def new
    @baiduvideo = Baiduvideo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @baiduvideo }
    end
  end

  # GET /baiduvideos/1/edit
  def edit
    @baiduvideo = Baiduvideo.find(params[:id])
  end

  # POST /baiduvideos
  # POST /baiduvideos.json
  def create
    @baiduvideo = Baiduvideo.new(params[:baiduvideo])

    respond_to do |format|
      if @baiduvideo.save
        format.html { redirect_to @baiduvideo, notice: 'Baiduvideo was successfully created.' }
        format.json { render json: @baiduvideo, status: :created, location: @baiduvideo }
      else
        format.html { render action: "new" }
        format.json { render json: @baiduvideo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /baiduvideos/1
  # PUT /baiduvideos/1.json
  def update
    @baiduvideo = Baiduvideo.find(params[:id])

    respond_to do |format|
      if @baiduvideo.update_attributes(params[:baiduvideo])
        format.html { redirect_to @baiduvideo, notice: 'Baiduvideo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @baiduvideo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /baiduvideos/1
  # DELETE /baiduvideos/1.json
  def destroy
    @baiduvideo = Baiduvideo.find(params[:id])
    @baiduvideo.destroy

    respond_to do |format|
      format.html { redirect_to baiduvideos_url }
      format.json { head :no_content }
    end
  end
  
end
