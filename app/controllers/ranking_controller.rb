class RankingController < ApplicationController
  layout 'review_site'

  before_action :ranking
  def ranking
    @review_anking = Product.limit(5)
    product_ids = Review.group(:product_id).order('count_product_id DESC').limit(5).count(:product_id).keys
    @review_ranking = product_ids.map {|id| Product.find(id)}

    @rate_ranking = Product.limit(5)
    product_ids = Review.group(:product_id).order('count_product_id DESC').limit(5).count(:product_id).keys
    @rate_ranking = product_ids.map {|id| Product.find(id)}


    # 以下評価のランキング

    rate_product_ids = Review.order("product_id ASC").pluck(:product_id).uniq!

    reviews = [] #product_id毎のrateを集計
    rate_product_ids.each do |p_id|

      rate_sum = Review.where(product_id: p_id).pluck(:rate).inject(0) { |sum, i| sum + i }

      reviews << rate_sum
    end
    #"count_product_id DESC"ではなく"product_id ASC"に書き換えた
    review_sum = Review.group(:product_id).order('product_id ASC').count(:product_id).to_a

    last_answer = []
    reviews.zip(review_sum).each do |ra_sum, re_sum|
      last_ha = {}
      answer = ra_sum.quo(re_sum[1].to_f)

      last_ha[:pro_id] = re_sum[0]
      last_ha[:ave] = answer
      last_answer << last_ha

    end

    last_answer.sort_by{|k,v| v }
    
    binding.pry

    # 以下最後にaveの順に並び替えてそのハッシュの配列からpro_idの情報だけを上から５個取り出して配列にする。そして最後にReview〜みたいな形でデータを取り出す。




  end
end
