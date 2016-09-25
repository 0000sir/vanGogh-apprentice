Rails.application.routes.draw do
  get 'style/index'

  get 'style/show'

  get 'style/new'

  get 'style/create'

  get 'style/edit'

  get 'style/update'

  get 'style/destroy'

  resources :artworks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
