Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'listings#index'
  resources :users, except: [:destroy, :index] do
    member do
      get :confirm_email
      get :new_password
    end
  end
  post 'sign_in' => 'sessions#create', as: :sign_in
  delete 'log_out' => 'sessions#destroy', as: :log_out
  get 'joining' => 'welcome#joining'
  get 'charter' => 'welcome#charter'
  get 'legend' => 'welcome#legend'
  get 'experience_calc' => 'welcome#experience_calc'
  post 'check_experience' => 'welcome#check_experience'
  resources :listings
  resources :news_comments, only: [:create, :update, :destroy]
  resources :clan_members, except: [:show]
  get 'admining_members' => 'clan_members#admining_members'
  get 'forum' => 'forum#index'
  resources :groups, except: [:index, :edit, :update]
  resources :themes, except: [:index, :edit, :update]
  resources :topics
  resources :posts
  resources :users, only: [:index, :show] do
    collection do
      get "touch"  # touch для current_user, чтобы обновить время онлайна
      get "metrics" # разнообразная статистика
    end
  end
  get 'please_log_in' => 'forum#please_log_in'
  get 'no_access' => "forum#no_access"
  get "reset_password" => "users#reset_password"
  get "resend_email_confirmation" => "users#resend_email_confirmation"
  post 'email_for_new_password' => "users#email_for_new_password"
  post 'repeat_email_confirmation' => "users#repeat_email_confirmation"
end
