Rails.application.routes.draw do
  root 'boards#index'
  #CRUD

  #C - new, create
  get '/boards/new' => 'boards#new' #new
  post '/boards' => 'boards#create'#created

  #R - index, show
  get '/boards'=>'boards#index' #index
  get '/boards/:id' => 'boards#show' #show


  #U -edit, update
  get '/boards/:id/edit' => 'boards#edit' #기존(/boards/edit/:id)이랑 똑같이 작동함 목적지가 boards#edit이니깐
  # post '/boards/:id' =>'boards#update'
  post '/boards/:id' =>'boards#update'

  #D - delete
  delete '/boards/:id' => 'boards#destroy'

  #sign in
  get '/signin' => 'sessions#signin'
  post '/signin' => 'sessions#user_signin'

  #sign up
  get '/signup' => 'sessions#signup'
  post '/signup' => 'sessions#user_signup'

  #sign out
  delete '/signout' => 'sessions#signout'

  post '/boards/:id/like' => 'boards#like_board'
  post '/boards/:id/create_comment' => 'boards#create_comment'
end
