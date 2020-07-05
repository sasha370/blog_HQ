class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]


  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end


  def new
    @user = User.new
  end

  def edit
  end

  def show
    # Данная переменная нужна, чтобы отображать Все статьи одного ползователя
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end


  def update

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Изменения созранены' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def create
    @user = User.new(user_params)

    respond_to do |format|
      # Если сохранение удачно, то перенаправляем на шаблон show, в котором есть место для notice
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to user_path(@user), notice: "Пользователь #{@user.username} успешно создан" }
        format.json { render :show, status: :created, location: @user }
      else
        # если сохранение неудачно, то открываем шаблон NEW ? который подсасывает форму, в которой есть Errors
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end


end