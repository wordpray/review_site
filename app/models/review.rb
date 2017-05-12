class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  ##validation(review)
  validates :review,presence: true
end
