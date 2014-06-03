Madlibs::Application.routes.draw do
  resources :mad_libs, only: [:new, :create, :show]

  resources :solutions, only: [:create, :show]

  root :to => 'mad_libs#new'
end
