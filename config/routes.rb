Rails.application.routes.draw do
  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'posts#index'

  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end

  get 'notifications', to: 'notifications#index'
  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through

  get 'browse', to: 'posts#browse', as: :browse_posts

  get ':user_name', to: 'profiles#show', as: :profile, constraints: {:user_name => /[\w+\.]+/}
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile, constraints: {:user_name => /[\w+\.]+/}
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile, constraints: {:user_name => /[\w+\.]+/}

  post ':user_name/follow', to: 'relationships#follow_user', as: :follow
  post ':user_name/unfollow', to: 'relationships#unfollow_user', as: :unfollow

end
