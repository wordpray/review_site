class Scraping
  def self.darts_urls
    links = []
    agent = Mechanize.new
    next_url = ""

    while true
    current_page = agent.get("http://item.s-darts.com/%E3%83%80%E3%83%BC%E3%83%84/csi/1/1?display=1&out_product=1&page=2&stock=1#category_search_items" + next_url)
    elements = current_page.search('.list2_row01 a')
    elements.each do |ele|
      links << ele.get_attribute('href')
    end

    next_link = current_page.at('.pagination .next a')
      break unless next_link
      next_url = next_link.get_attribute('href')
    end

    links.each do |link|
      get_product(link)
    end
  end

  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.detail_box0102_wrap h2').inner_text if page.at('.detail_box0102_wrap h2')
    image_url = page.at('.jqzoom img')[:src] if page.at('.jqzoom img')

    product = Product.where(title: title, image_url: image_url).first_or_initialize
    product.save
  end
end