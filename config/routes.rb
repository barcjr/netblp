Netblp::Application.routes.draw do
  namespace :v1 do
    resources :books, except: [:new, :edit] do
      resources :contacts, except: [:new, :edit]
    end
  end
end
