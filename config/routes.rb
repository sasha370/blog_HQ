Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # задаем путь в виде Контроллер\ метод в контроллере, который будет обрабатывать запрос
  # в даннои случае базовый контроллер, у которого должен быть метод HELLO
  root 'pages#home'

end
