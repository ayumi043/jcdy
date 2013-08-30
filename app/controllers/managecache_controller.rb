class ManagecacheController < ApplicationController
  
  def clear_home
    # binding.pry
    # expire_action :controller => :home, :action => :index
    expire_page :controller => "home", :action => "index"
    redirect_to("/admin/")
  end

  def clear_all
    ActionController::Base.cache_store.clear
    # binding.pry
    redirect_to("/admin/")
  end

end