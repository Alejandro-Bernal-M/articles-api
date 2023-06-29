class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles, status: 200
  end

  def show
    article = Article.find(params[:id])
    if article
      render json: article, status: 200
    else
      render json: { error: "Article not found" }, status: 404
    end
  end

  def create
    article = Article.new(article_params)
    if article.save
      render json: {id: article.id, title: article.title}, status: 201
    else
      render json: { error: article.errors.messages }, status: 422
    end
  end

  def update
    article = Article.find(params[:id])
    if article
      article.update(article_params)
      render json: article, status: 200
    else
      render json: { error: "Article not found" }, status: 404
    end
  end

  def destroy
    article = Article.find(params[:id])
    if article
      article.destroy
      render json: { message: "Article deleted" }, status: 200
    else
      render json: { error: "Article not found" }, status: 404
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :author)
  end
end
