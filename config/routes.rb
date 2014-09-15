Zdrav::Application.routes.draw do
  mount ElVfsClient::Engine => '/'

  namespace :manage do
    resources :thanks, :except => :show

    root :to => 'thanks#index'
  end

  resources :thanks, :only => :index

  get "/ru/dlya-naseleniya/obrascheniya-grazhdan/blagodarnosti-patsientov" => 'thanks#index', :as => :thanks

  get '/(*path)', :to => 'main#index'

  root :to => 'main#index'
end
