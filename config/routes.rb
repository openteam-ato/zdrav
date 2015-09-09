Rails.application.routes.draw do

  mount ElVfsClient::Engine => '/'

  put '/ali.txt' => redirect('http://alihack.com')

  devise_for :users, :path => 'auth', :controllers => {:omniauth_callbacks => 'sso/auth/omniauth_callbacks'}, :skip => [:sessions]
  devise_scope :users do
            delete 'sign_out' => 'sso/auth/sessions#destroy', :as => :destroy_user_session
            get    'sign_in' => redirect('/auth/auth/identity'), :as => :new_user_session
          end

  scope  'ru' do
    get  'dlya-naseleniya/obrascheniya-grazhdan/blagodarnosti-patsientov'                       => 'thanks#index',    :as => :thanks
    get  'dlya-naseleniya/obrascheniya-grazhdan/blagodarnosti-patsientov/ostavit-blagodarnost'  => 'thanks#new',      :as => :new_thank
    post 'dlya-naseleniya/obrascheniya-grazhdan/blagodarnosti-patsientov'                       => 'thanks#create',   :as => :create_thank
    get  'thanks/publish'                                                                       => 'thanks#publish',  :as => :publish_thank
    get  'thanks/remove'                                                                        => 'thanks#remove',   :as => :remove_thank

    get  'zdravoohranenie-v-tomskoy-oblasti/spetsialistam/birzha-idey'                          => 'idea#show'
    post 'zdravoohranenie-v-tomskoy-oblasti/spetsialistam/birzha-idey'                          => 'idea#create'

    get  'zdravoohranenie-v-tomskoy-oblasti/novaya-model-tomskogo-zdravoohraneniya/predlagaem-k-obsuzhdeniyu-proekt-novoy-modeli-tomskogo-zdravoohraneniya/otpravit-vopros-ili-predlozhenie' => 'new_model#show'
    post 'zdravoohranenie-v-tomskoy-oblasti/novaya-model-tomskogo-zdravoohraneniya/predlagaem-k-obsuzhdeniyu-proekt-novoy-modeli-tomskogo-zdravoohraneniya/otpravit-vopros-ili-predlozhenie' => 'new_model#create'

    get  'zdravoohranenie-v-tomskoy-oblasti/spetsialistam/zemskiy-doktor/uchastniki'            => 'doctors#index', :as => :doctors
    get  'zdravoohranenie-v-tomskoy-oblasti/spetsialistam/zemskiy-doktor/uchastniki/:id'        => 'doctors#show',  :as => :doctor

    get  'konkurs-poliklinika-nachinaetsya-s-registratury/otvetit-na-voprosy-ankety/done'       => 'evaluation_registry#show',   :as => :evaluation_registry_done
    get  'konkurs-poliklinika-nachinaetsya-s-registratury/otvetit-na-voprosy-ankety'            => 'evaluation_registry#new',    :as => :evaluation_registry_new
    post 'konkurs-poliklinika-nachinaetsya-s-registratury/otvetit-na-voprosy-ankety'            => 'evaluation_registry#create', :as => :evaluation_registry_post_create
    put  'konkurs-poliklinika-nachinaetsya-s-registratury/otvetit-na-voprosy-ankety'            => 'evaluation_registry#create', :as => :evaluation_registry_put_ceate
  end

  namespace :manage do
    resources :thanks, :except => :show do
      get ':by_state' => 'thanks#index', :on => :collection, :as => :by_state, :constraints => { :by_state => :draft }
      put 'change' => 'thanks#change', :on => :member, :as => :change
    end

    resources :doctors

    resources :evaluation_registries do
      get :xls, :on => :collection
    end

    root :to => 'thanks#index'
  end

  namespace :eco do
    resources :eco_coupons

    root :to => 'eco_coupons#index'
  end

  get '/ru/(*path)', :to => 'main#index'

  root :to => 'main#index'
end
