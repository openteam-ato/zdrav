Zdrav::Application.routes.draw do
  mount ElVfsClient::Engine => '/'

  devise_for :users, :path => 'auth',
    :controllers => {:omniauth_callbacks => 'sso_auth/omniauth_callbacks'},
    :skip => [:sessions]

  devise_scope :users do
    get 'sign_out' => 'sso-auth/sessions#destroy', :as => :destroy_user_session
    get 'sign_in' => redirect('/auth/auth/identity'), :as => :new_user_session
  end

  scope 'ru' do
    get  'dlya-naseleniya/obrascheniya-grazhdan/blagodarnosti-patsientov'                      => 'thanks#index',  :as => :thanks
    get  'dlya-naseleniya/obrascheniya-grazhdan/blagodarnosti-patsientov/dobavit-blagodarnost' => 'thanks#new',    :as => :new_thank
    post 'dlya-naseleniya/obrascheniya-grazhdan/blagodarnosti-patsientov'                      => 'thanks#create', :as => :create_thank
  end

  namespace :manage do
    resources :thanks, :except => :show do
      get ':by_state' => 'thanks#index', :on => :collection, :as => :by_state, :constraints => { :by_state => :draft }
      put 'change' => 'thanks#change', :on => :member, :as => :change
    end

    root :to => 'thanks#index'
  end

  get '/ru/(*path)', :to => 'main#index'

  root :to => 'main#index'
end
