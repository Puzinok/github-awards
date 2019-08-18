Rails.application.routes.draw do
  root to: "awards#index"

  resources :awards, only: [:index, :create]
  
  get '/downloads/:repo/:login', to: 'awards#download', as: :download
  get '/downloads/:repo', to: 'awards#download_zip', as: :download_zip
end
