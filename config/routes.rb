Netblp::Application.routes.draw do
  resources :books, only: [:show]

  namespace :v1 do
    resources :books, except: [:new, :edit] do
      resources :contacts, except: [:new, :edit]
      resources :operators, only: [:index]
    end
  end
end
