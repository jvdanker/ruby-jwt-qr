Rails.application.routes.draw do
  resources :tokens
  get '/tokens/:id/revoke', to: 'tokens#revoke', as: 'revoke_token'
  get '/tokens/:id/activate', to: 'tokens#activate', as: 'activate_token'
  get '/tokens/:id/validate', to: 'tokens#validate', as: 'validate_token'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
