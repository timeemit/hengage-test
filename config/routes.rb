HengageTest::Application.routes.draw do
  root :to => 'users#new'
  devise_for :users
end
