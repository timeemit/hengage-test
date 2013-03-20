HengageTest::Application.routes.draw do
  resources :projects


  root :to => 'users#index'
  devise_for :users
  resources :users, except: :destroy
end
