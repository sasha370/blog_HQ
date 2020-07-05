Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # задаем путь в виде Контроллер\ метод в контроллере, который будет обрабатывать запрос
  # в даннои случае базовый контроллер, у которого должен быть метод HELLO
  root 'pages#home'

  # Все запросы GET на страницу About отправляем в контроллер pages и обрабатываем методом about
  get 'about', to: 'pages#about'
  resources :articles # прописываем все возможные пути для Articles по CRUD

  # переадресуем запрос на создание User на страницу с названием signup
  get 'signup', to: 'users#new'

  resources :users, except: [:new]


end
