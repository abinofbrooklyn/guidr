require "monban/constraints/signed_in"
require "monban/constraints/signed_out"

Rails.application.routes.draw do
  constraints Monban::Constraints::SignedIn.new do
    root "listings#new"
  end

  constraints Monban::Constraints::SignedOut.new do
    root "sessions#new", as: :landing
  end

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create] do
    resources :conversations, only: [:new, :create]
  end

  get "search" => "search_results#show"

   resources :listings, only: [:new, :create, :show] do
     resources :availabilities, only: [:new, :create]
     resources :reservations, only: [:new, :create]
     resources :user, only: [:show, :edit, :update]
   end

  resources  :conversations, only: [:index, :show] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  namespace :admin do
    resources :listings, only: [:destroy]
  end

  resources :reservations, only: [:show, :index] do
    resources :reviews, only: [:new, :create, :show]
  end
end
