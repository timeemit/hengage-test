HengageTest::Application.routes.draw do
  root :to => 'users#index'
  devise_for :users
  resources :users, except: :destroy
end
