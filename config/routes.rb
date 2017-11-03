Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  resources :users, except: [:destroy, :index]
  post 'sign_in' => 'sessions#create', as: :sign_in
  delete 'log_out' => 'sessions#destroy', as: :log_out
end
