### javascript

#### 1. CRUD 만들기

- model: board, user comment

- controller: boards, sessions

  - app/controllers/boards_controller.rb

    - CRUD

    - action: `index`,  `show`,  `new` , `create`, `edit`, `update`, `destroy`

    - config/routes.rb

      ```ruby
        #/  
        root 'boards#index'
        #CRUD
        #R - index, show
        get '/boards'=>'boards#index' #index
        get '/boards/:id' => 'boards#show' #show

        #C - new, create
        get '/boards/new' => 'boards#new' #new
        post '/boards' => 'boards#create'#created

        #U -edit, update
        get '/boards/:id/edit' => 'boards#edit' #기존(/boards/edit/:id)이랑 똑같이 작동함 목적지가 boards#edit이니깐
        # post '/boards/:id' =>'boards#update'
        put '/boards/:id' =>'boards#update'

        #D - delete
        delete '/boards/:id' => 'boards#destroy'
      ```

      - app/views/boards


      - `index.html.erb`, `show.html.erb`, `new.html.erb` , `edit.html.erb`
      - app/assets/stylesheets, app/assets/javascripts
        - ​
      - ​

#### 2. jQuery 기본

- css Selector
- jQuery에 있는 기본 함수들

