Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html\
  namespace :api do
    namespace :v1 do
      resources :locations do
        member do
          get 'confirmed'
          get 'deaths'
          get 'latest'
          get 'recovered'
        end
      end
    end
  end
end
