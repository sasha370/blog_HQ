require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    # отправляемся по данному адресу
    get '/categories/new'
    # должны получить положительный ответ код200
    assert_response :success

    # Далее проверяем повышения счетчика категорий
    assert_difference 'Category.count', 1 do
      # для этого нужно послать POST запрос * заполенить форму) с данными параметра
      post categories_path, params: { category: { name: 'Sports' } }
      # в ответ ждем код 300 - редирект
      assert_response :redirect
    end


    # Переходим на редирект
    follow_redirect!
    # код200 после редиректа
    assert_response :success

    # На странице ищем совпадение SPORTS  в html теге BODY
    assert_match "Sports", response.body
  end
end
