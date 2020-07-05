class PagesController < ApplicationController

  # Метод Home имеет свой шаблон отображения Pages/Home
  def home
    redirect_to articles_path if logged_in?
  end

  # Метод About имеет свой шаблон отображения Pages/about
  def about
  end
end
