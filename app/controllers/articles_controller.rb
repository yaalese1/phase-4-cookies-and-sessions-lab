class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    articles = Article.all.includes(:user).order(created_at: :desc)
    render json: articles, each_serializer: ArticleListSerializer
  end

  # def show
  #   article = Article.find(params[:id])
  #   render json: article
    
  # end

  def page_view
    session[:page_views] ||=0
    session [:page_views] +=1
    if 
     session[:page_views] <=3
      article = Article.find_by(id: params[:id])
      render json: artice 
    else

   maximum_views
    end

  end 

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end
 def maximum_views
  render json: { error: "you have reached your maxed views, please subscribe to continue"}, status:  503 
 end
end
