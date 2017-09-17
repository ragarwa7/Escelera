Rails.application.routes.draw do

  devise_for :users
  root 'users#index'

  get '/secret', to: 'pages#secret', as: :secret
=begin
  get 'bookings/new'

  get 'bookings/create'

  get 'bookings/update'

  get 'bookings/edit'

  get 'bookings/destroy'

  get 'bookings/index'

  get 'bookings/show'

  get 'cars/new'

  get 'cars/create'

  get 'cars/update'

  get 'cars/edit'

  get 'cars/destroy'

  get 'cars/index'

  get 'cars/show'

  get 'users/new'

  get 'users/create'

  get 'users/update'

  get 'users/edit'

  get 'users/destroy'

  get 'users/index'

  get 'users/show'
=end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
