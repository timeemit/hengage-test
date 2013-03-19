HengageTest::Application.routes.draw do
  resources :users, except: :destroy
  root :to => 'users#new'
  devise_for :users
end
