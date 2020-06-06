Rails.application.routes.draw do
  #get 'users/new'
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  
  resources :users
  # => contact_path '/contact'
  # => contact_url 'ドメイン名/contact'
end

#Rails.application.routes.draw do
#  get 'users/new'
#  root 'static_pages#home'
  # root 'application#hello'
#  get 'static_pages/home'
  # => StaticPages#home
#  get 'static_pages/help'
  # => StaticPages#help
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
#  get 'static_pages/about'
#  get 'static_pages/contact'
#end