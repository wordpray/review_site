class ProductsController < RankingController
  before_action :authenticate_user!,only: :search

  def index
    @products = Product.order('id ASC').page(params[:page]).per(20)
  end

  def show
    @product = Product.find(params[:id])
    #実装商品詳細ページ、ページネーション
    @product2 = Product.find(params[:id]).reviews.order('created_at DESC').page(params[:page]).per(10)
  end

  def search
    @products = Product.where('title LIKE(?)',"%#{params[:keyword]}%").page(params[:page]).per(10)
  end
end
