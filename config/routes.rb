TechReviewSite::Application.routes.draw do
  devise_for :users
  resources :users, only: :show
  resources :products, only: :show do
    resources :reviews,only: [:new, :create,:edit,:update,:destroy]  do 
      resources :likes, only: [:create, :destroy],shallow: true #shallow を追加してみた

    collection do
      get 'search'
    end
  end
  end
  root 'products#index'
end
