class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def current_user
    # Если у нас уже есть Текущий пользователь, то мы просто возвращаем его,
    # если его нет, то создаем нового
    # "nj нужно, чтобы каждый раз не запрашивать БД
    @carrent_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def logged_in?
    # превращает переиенную в Булевое значение
    !!current_user
  end


end
