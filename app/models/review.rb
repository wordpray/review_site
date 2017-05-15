class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  ##validation(review)
  validates :review,presence: true

  has_many :likes, dependent: :destroy
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
