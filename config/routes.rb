HengageTest::Application.routes.draw do
  get "user/show"

  get "user/index"

  get "user/new"

  get "user/edit"

  get "user/create"

  get "user/update"

  root :to => 'users#new'
  devise_for :users
end
