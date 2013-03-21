HengageTest::Application.routes.draw do
  resources :time_blocks


  root :to => 'users#index'
  devise_for :users
  resources :users, except: :destroy
  resources :projects, except: :destroy
end
