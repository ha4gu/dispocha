Rails.application.routes.draw do
  # static_pages
  root 'static_pages#top'

  # rooms
  resources :rooms

  # personas
  post   '/rooms/:id/apply', to: 'personas#create', as: 'personas'
  get    '/rooms/:id/apply', to: 'personas#new',    as: 'new_persona'
  get    '/rooms/:id/customize', to: 'personas#edit',   as: 'edit_persona'
  match  '/rooms/:id/customize', to: 'personas#update', as: 'update_persona', via: [:patch, :put]
  delete '/rooms/:id/leave', to: 'personas#destroy', as: 'delete_persona'

  # accounts - devise
  devise_for :accounts

end
