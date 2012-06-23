Netblp::Application.routes.draw do
  resources :books, only: [:show] do
    resources :contacts, only: [:index]
  end

  namespace :v1 do
    resources :books, except: [:new, :edit] do
      resources :contacts, except: [:new, :edit]
      resources :operators, only: [:index, :create]
      resources :stations, only: [:index, :show]
      resources :radios, except: [:new, :edit, :destroy]
    end
  end
end
