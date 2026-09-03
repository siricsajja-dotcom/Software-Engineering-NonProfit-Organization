# frozen_string_literal: true

# This file tells the Rails server how incoming requests are sent to which
# controller and method.
#
#
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # The root page, e.g. www.example.com/, is sent here
  # root 'controller#method_in_controller'
  root 'home#index'
  # Devise authentification pages. This controlls the user login
  # and authentification system.

  devise_for :users

  resources :hours, only: [] do
    collection do
      post :checkin
      post :checkout
      post :approve
    end
  end
  
  resources :events, only: [:create]
  get 'history/filter', to: 'history#filter'

  post '/hours/checkin', to: 'hours#checkin'
  post '/hours/checkout', to: 'hours#checkout'
  post '/hours/approve', to: 'hours#approve'

  post '/events/create', to: 'events#create'
end
