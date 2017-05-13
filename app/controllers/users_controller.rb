class UsersController < ApplicationController
  def show
    @reviews = current_user.reviews.order('updated_at DESC').page(params[:page]).per(12)
  end

end
