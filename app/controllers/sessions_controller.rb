class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Вы успешно вошли"
      redirect_to user
    else
      flash.now[:alert] = "Вы что-то ввели неправильно"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Вы вышли"
    redirect_to root_path
  end
end
