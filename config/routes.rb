Zdrav::Application.routes.draw do
  mount ElVfsClient::Engine => '/'

  devise_for :users, :path => 'auth',
    :controllers => {:omniauth_callbacks => 'sso_auth/omniauth_callbacks'},
    :skip => [:sessions]

  devise_scope :users do
    get 'sign_out' => 'sso-auth/sessions#destroy', :as => :destroy_user_session
    get 'sign_in' => redirect('/auth/auth/identity'), :as => :new_user_session
  end

  namespace :manage do
    resources :thanks, :except => :show

    root :to => 'thanks#index'
  end

  resources :thanks, :only => :index

  get "/ru/dlya-naseleniya/obrascheniya-grazhdan/blagodarnosti-patsientov" => 'thanks#index', :as => :thanks

  get '/ru/(*path)', :to => 'main#index'

  root :to => 'main#index'
end
