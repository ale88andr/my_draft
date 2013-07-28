MyDraft::Application.routes.draw do

  namespace :backend do
    resources :users, :tags, :categories, :books, :book_categories
    resources :articles, constraints: { :id => /[0-9]+(\%7C[0-9]+)*/ } do
      get 'unpublished', :action => :unpublished, on: :collection
      resources :comments, :only => [:create, :edit, :destroy]
    end
  end

  resources :articles, :only => [:show, :index], constraints: { :id => /[0-9]+(\%7C[0-9]+)*/ } do
    # kaminari
    get 'page/:page', :action => :index, :on => :collection
    get 'unpublished', :on => :collection
    get 'option/:option', :action => :index, :on => :collection
    resources :comments, :only => [:create]
  end

  devise_for :users

  get "users/show"
  get "comments/create"

  resources :categories, :only => [:show, :index]
  resources :tags, :only => [:show, :index]
  resources :books
  resources :users, :only => [:show]

  get "static_pages/home"
  get "/about", :to => 'static_pages#about'
  get "static_pages/help"

  root :to => 'static_pages#home'

  #unless Rails.application.config.consider_all_requests_local
    match '*path', to: 'application#error_from_route'
  #end

end
