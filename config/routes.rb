Rails.application.routes.draw do

  resources :web_pages do
    get :home_page , :on => :collection
  end

  devise_for :users, controllers: {
    sessions: 'devise/sessions'
  }

  devise_scope :users do
    root 'devise/sessions#new'
  end
  get '/home_page' => "web_pages#home_page", :as => :home_page_root

end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
