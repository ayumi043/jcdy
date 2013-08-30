Jcdy::Application.routes.draw do

  root :to => 'home#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  
  ActiveAdmin.routes(self)

  # resources :kuaibovideos
  # resources :baiduvideos

  get '/admin/managecache/home' => "managecache#clear_home"
  get '/admin/managecache/all' => "managecache#clear_all"

  get 'sitemap', :to => 'sitemaps#show'

  get "live" => "lives#index", :as => :live

  # get 'comedy' =>  "categories#comedy" 
  get "videos/movie_:id/(:n)" => "videos#play_movie", :as => :movie_videos
  get "movies/categories/:id/(page/:page)" => "categories#show", :as => :category
  get 'movies/search/(:q)' => "search#index", :constraints => { :q => /[^\/]*/ }, :as => "movies_all_search"  #调一下顺序看看啊
  get 'movies/search/name/(:q)' => "search#find_movie_by_name", :constraints => { :q => /[^\/]*/ }, :as => "movies_name_search"  #调一下顺序看看啊
  get 'movies/search/actor/(:q)' => "search#find_movie_by_actor", :constraints => { :q => /[^\/]*/ }, :as => "movies_actor_search"
  resources :movies do
    
    # collection do
    #   get  :sold
    #   post :on_offer
    # end

    # get "categories/:id" => "movies#category", :on => :collection

    # get :sold, :on => :member

    get 'page/:page', :action => :index, :on => :collection
  end  
  

end
