ActiveAdmin.register Movie do

  filter :category_ids, :as => :check_boxes, :collection => proc { Category.all.order_by(:sortid => :asc) }, :label => '影片类别'
  filter :name, :as => :string, :lable => '影片名称'

  config.per_page = 15

  controller do
    def new
      @movie = Movie.new
      3.times { baiduvideo = @movie.baiduvideos.build }

      # render 'admin/viewlogger/index', :layout => 'active_admin'
    end

    def edit
     @movie = Movie.find(params[:id])

      # render 'admin/viewlogger/index', :layout => 'active_admin'
    end

    def update
      # binding.pry
      @movie = Movie.find(params[:id])
      if @movie.update_attributes(params[:movie])
        # redirect_to @movie, :notice => "Successfully updated survey."
        redirect_to admin_movies_path
      else
        render :action => 'edit'
      end
    end
  end   


  index do
  	# binding.pry
    column "名称", :name                     
    column :pic do |movie|
      image_tag "http://jcdypic.b0.upaiyun.com#{movie.pic}!115", {:alt => movie.pic,:width => 60, :height => 50}
    end  
    column :actor
    column "分类", :sortable => :category_ids  do |movie|
      Category.find(movie.category_ids).map{|x| x.name}.join(", ") rescue nil
    end 
    default_actions  
  end

  form :partial => "form"

  # form do |f|                         
  #   f.inputs "Admin Details" do       
  #     f.input :name                  
  #     f.input :pic               
  #     f.input :hits     
  #     f.input :category_ids, :as => :select, :collection => Category.all, 
  #     				# :selected => "",
  #     				:input_html => { :size => 1 }
  #     # f.input :category_ids, :as => :check_boxes, :collection => Category.all, :input_html => { :size => 1 }
  #   	# f.collection_select :category_ids, Category.all, :id, :name   
  #   end                 

  #   f.actions                         
  # end   
end