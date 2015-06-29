Rails.application.routes.draw do

    get '/' => 'high_voltage/pages#show', id: 'home'
    
    get "users/new_release" => 'users#new_release', :as => :new_release

    get "/users/:user_id/join/:id" => "carpools#join_carpool", :as => :join_carpool

    get "users/:id/calendar" => "users#calendar", as: :calendar
    
    resources :sessions, only: [:create, :destroy, :new]
    resources :users do
      resources :carpools
    end
end

=begin
Prefix Verb   URI Pattern                                 Controller#Action
                GET    /                                           high_voltage/pages#show {:id=>"home"}
    new_release GET    /users/new_release(.:format)                users#new_release
       sessions POST   /sessions(.:format)                         sessions#create
    new_session GET    /sessions/new(.:format)                     sessions#new
        session DELETE /sessions/:id(.:format)                     sessions#destroy
  user_carpools GET    /users/:user_id/carpools(.:format)          carpools#index
                POST   /users/:user_id/carpools(.:format)          carpools#create
new_user_carpool GET    /users/:user_id/carpools/new(.:format)      carpools#new
edit_user_carpool GET    /users/:user_id/carpools/:id/edit(.:format) carpools#edit
   user_carpool GET    /users/:user_id/carpools/:id(.:format)      carpools#show
                PATCH  /users/:user_id/carpools/:id(.:format)      carpools#update
                PUT    /users/:user_id/carpools/:id(.:format)      carpools#update
                DELETE /users/:user_id/carpools/:id(.:format)      carpools#destroy
     user_rides GET    /users/:user_id/rides(.:format)             rides#index
                POST   /users/:user_id/rides(.:format)             rides#create
  new_user_ride GET    /users/:user_id/rides/new(.:format)         rides#new
 edit_user_ride GET    /users/:user_id/rides/:id/edit(.:format)    rides#edit
      user_ride GET    /users/:user_id/rides/:id(.:format)         rides#show
                PATCH  /users/:user_id/rides/:id(.:format)         rides#update
                PUT    /users/:user_id/rides/:id(.:format)         rides#update
                DELETE /users/:user_id/rides/:id(.:format)         rides#destroy
          users GET    /users(.:format)                            users#index
                POST   /users(.:format)                            users#create
       new_user GET    /users/new(.:format)                        users#new
      edit_user GET    /users/:id/edit(.:format)                   users#edit
           user GET    /users/:id(.:format)                        users#show
                PATCH  /users/:id(.:format)                        users#update
                PUT    /users/:id(.:format)                        users#update
                DELETE /users/:id(.:format)                        users#destroy
           page GET    /pages/*id                                  high_voltage/pages#show
=end
