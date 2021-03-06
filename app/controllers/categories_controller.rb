class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Категория успешно отредактирована' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end


  def create
    @category = Category.new(category_params)

    respond_to do |format|
      # Если сохранение удачно, то перенаправляем на шаблон show, в котором есть место для notice
      if @category.save
        format.html { redirect_to @category, notice: "Категория успешно создана" }
        format.json { render :show, status: :created, location: @category }
      else
        # если сохранение неудачно, то открываем шаблон NEW ? который подсасывает форму, в которой есть Errors
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Это позволено только админисратору"
      redirect_to categories_path
    end
  end
end
