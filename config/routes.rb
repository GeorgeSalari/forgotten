Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'listings#index'
  resources :users, except: [:destroy, :index] do
    member do
      get :confirm_email
    end
  end
  post 'sign_in' => 'sessions#create', as: :sign_in
  delete 'log_out' => 'sessions#destroy', as: :log_out
  get 'joining' => 'welcome#joining', as: :joining
  get 'charter' => 'welcome#charter', as: :charter
  get 'legend' => 'welcome#legend', as: :legend
  resources :listings
  resources :news_comments, only: [:create, :update, :destroy]
  resources :clan_members, except: [:show]
  get 'admining_members' => 'clan_members#admining_members'
  get 'forum' => 'forum#index'
end
