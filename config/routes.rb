HengageTest::Application.routes.draw do
  root :to => 'users#index'
  devise_for :users
  resources :users, except: :destroy
  resources :projects, except: :destroy
  resources :time_blocks, except: :show
end
