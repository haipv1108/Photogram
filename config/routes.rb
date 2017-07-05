Rails.application.routes.draw do
  get 'relationships/follow_user'

  get 'relationships/unfollow_user'

  get 'notifications/link_through'

  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'posts#index'

  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end

  get 'notifications', to: 'notifications#index'
  get 'notifications/:id/link_through', to: 'notifications#link_through',
      as: :link_through

  post ':user_name/follow', to: 'relationships#follow_user', as: :follow, constraints: {:user_name => /[\w+\.]+/}
  post ':user_name/unfollow', to: 'relationships#unfollow_user', as: :unfollow, constraints: {:user_name => /[\w+\.]+/}
  get ':user_name', to: 'profiles#show', as: :profile, constraints: {:user_name => /[\w+\.]+/}
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile, constraints: {:user_name => /[\w+\.]+/}
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile, constraints: {:user_name => /[\w+\.]+/}
end
