Rails.application.routes.draw do
  # static_pages
  root 'static_pages#top'

  # rooms
  resources :rooms

  # accounts - devise
  devise_for :accounts

end
