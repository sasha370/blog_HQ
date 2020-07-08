require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # @article = Article.first
    @article  = Article.last
    #     Article.create(title: 'weqweqweqweqw', description: "sdfsdfsdfsdfsdfsdfsdf", user_id: '1')
    # @user = User.create(username: 'sasha', email: 'asda@asd.rk', password: 'password', admin: false)
    # sigh_in_as(@user)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do

    get new_article_url
    assert_response :success
  end

  test "should create article" do

    assert_difference('Article.count') do
      post articles_url, params: { article: { description: @article.description, title: @article.title } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article), params: { article: { description: @article.description, title: @article.title } }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end
    assert_redirected_to articles_url
  end
end
