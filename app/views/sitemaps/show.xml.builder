xml.instruct! :xml, :version => '1.0', :encoding => 'UTF-8'

xml.urlset :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do

  @categories.each do |category|
    xml.url do
      xml.loc category_url(category)
      xml.changefreq "daily"
      xml.priority 0.8
    end
  end

  @movies.each do |movie|
    xml.url do
      xml.loc movie_url(movie)
      xml.lastmod movie.created_at.strftime('%Y-%m-%d')
      xml.changefreq "daily"
      xml.priority 0.7
    end
  end

  # @tags.each do |tag|
  #   xml.url do # create the url entry, with the specified location and date
  #     xml.loc tag_url(tag)
  #     xml.lastmod tag.updated_at.strftime('%Y-%m-%d')
  #     xml.changefreq "monthly"
  #     xml.priority 0.5
  #   end
  # end

end