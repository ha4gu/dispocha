Rails.application.routes.draw do
  # static_pages
  root 'static_pages#top'

  # rooms
  resources :rooms

end
