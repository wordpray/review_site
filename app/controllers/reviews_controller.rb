class ReviewsController < RankingController
before_action :authenticate_user!,only: :new

  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def create
    @review = Review.create(create_params)
    redirect_to "/products/#{@review.product_id}"
    #redirect_to controller: :products,action: :index
  end

  def edit
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
  end

  def update
      @review = Review.find(params[:id])
       if @review.user_id == current_user.id
        @review.update(create_params)
      end
      redirect_to "/products/#{@review.product_id}"
      # redirect_to controller: :products,action: :index
  end

  def destroy
    review = Review.find(params[:id])
    if review.user_id == current_user.id
      review.destroy
    end
    redirect_to :back
    #redirect_to controller: :products,action: :index
  end

  private
  def create_params
    params.require(:review).permit(:rate,:review).merge(product_id: params[:product_id],user_id: current_user.id)
  end
end
