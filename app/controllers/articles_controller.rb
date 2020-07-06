class ArticlesController < ApplicationController

  # В первую очередь создаемп переменную @ article Только для данных методов, т.к. они принимают ID
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  # Создать переменную в которой лежат все записи из таблицы
  def index
    @articles = Article.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    # @articles = Article.all.order(created_at: :desc)
  end

  # GET /articles/1
  # GET /articles/1.json
  # Ничего не обрабатывает, просто пересылает на Страницу
  def show
  end

  # GET /articles/new
  # Сощдаем пустую переменную, т.к. для отображения Шаблона нам нужен ID
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  # Ничего не делает с данными, просто отображает Шаблон . Данные ID берутся из созданного в самом начале
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    # Создаем новую переменную, в которую записываем разрешенные данные
    @article = Article.new(article_params)
    @article.user = current_user

    respond_to do |format|
      # Если сохранение удачно, то перенаправляем на шаблон show, в котором есть место для notice
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        # если сохранение неудачно, то открываем шаблон NEW ? который подсасывает форму, в которой есть Errors
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy

    # берем переменную, созданную вначале с ID и отображаем сообщение в случае удачи
    # Все отображается через форму SHOW
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  #данный метод создаеи переменную по ID текущей статьи
  def set_article
    @article = Article.find(params[:id])
  end

  # разрешает принимать параметры из передаваемого params
  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "Вы можете удалять или редактировать только свои статьи"
      redirect_to @article
    end
  end

end
