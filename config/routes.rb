Rails.application.routes.draw do

  devise_for :users, :controllers => { :registrations => "users/registrations" }

  resources :jobs do
    collection do
      get :grow
      get :study
      get :cognitive
      get :search
    end
    resources :resumes
  end

  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end
  end

  namespace :account do
    resources :jobs
  end

  namespace :groups do
    resources :grow
    resources :study
    resources :cognitive
  end

  root 'welcome#index'
end
