# encoding: utf-8
require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'pry'

namespace :assets do
  desc 'fetch movies'
  task :get_movies => :environment do |t, args|
    
    # MovieFetch.new.get_all
    # MovieFetch.new.test_luanma
    # MovieFetch.new.download_all_img

    Bdzy.new.get_all
    # Bdzy.new.get_detail(1)
    
    # ActionController::Base.cache_store.clear
    # expire_page :controller => "home", :action => "index"

    
    # Movie.each{ |x| download_img_from_local(x.pic) }

    # per_batch = 1000
    # 0.step(Movie.count, per_batch) do |offset|
    #     # puts Movie.limit(per_batch).skip(offset).map(&:pic).inspect
    #     Movie.order_by(:created_at => :desc).limit(per_batch).skip(offset).map(&:pic).each{ |x| download_img_from_local(x) }
    # end

  end

  desc 'fetch movies'
  task :get_movies_1 => :environment do |t, args| 
    per_batch = 1000
    0.step(Movie.count, per_batch) do |offset|
        Movie.order_by(:created_at => :asc).limit(per_batch).skip(offset).map(&:pic).each{ |x| download_img_from_local(x) }
    end
  end

  # desc 'fetch movies'
  # task :get_movies, [:m, :n] => :environment do |t, args|
  #   # MovieFetch.new.get_detail(8)   
  #   puts args.m
  #   puts args.n
  #   MovieFetch.new.get_all(args.m, args.n)
  # end
end

class MovieFetch

  def initialize()
    
  end

  def get_all
    (1..805).to_a.reverse.select {|x| get_urls(x) }
  end
 
  # def get_all(m=1,n=805)
  #   (1..805).to_a.reverse.select {|x| get_urls(x) }
  #   # (m..n).to_a.reverse.select {|x| get_urls(x) }
  # end

  def get_urls(page)
    # "http://www.7k7kk.org/film/class/-24-0-0-0-804-0-1_2_3_4_5_6_7_8_9_10-.html"
    begin
      # @doc = Nokogiri::HTML(open("http://www.7k7kk.org/film/class/-24-0-0-0-#{page}-0-1_2_3_4_5_6_7_8_9_10-.html"), nil, "gb2312")

      html = open("http://www.7k7kk.org/film/class/-24-0-0-0-#{page}-0-1_2_3_4_5_6_7_8_9_10-.html").read
      html.force_encoding("gbk")
      html.encode!("utf-8")
      @doc = Nokogiri::HTML.parse html

    rescue Errno::ECONNRESET => e
      # retry unless count++ > 10
      # puts "tried 10 times and couldn't get #{url}: #{e}"
    end  

    #a_name = @doc.css(".a333 a").first.attr('href').delete "#"

    puts @doc.css(".yi_c ul li:first a").count
    
    @doc.css(".yi_c ul li:first a").each do |item|

      puts item.attr('title') # :name
      # puts item.css('img').attr('src') # :pic

      if Movie.where(:name => item.attr('title')).count > 0
        next
      end  

      begin
        detail = get_detail item.attr('href')

        movie = Movie.new
        movie.name = item.attr('title')          # :name
        movie.pic = item.css('img').attr('src').value  # :pic
        movie.area = detail[:area]
        movie.actor = detail[:actor]
        movie.release =detail[:release]
        movie.intro = detail[:intro]
        movie.category_ids = detail[:category_ids]
        movie.baiduvideos = detail[:baiduvideos_attributes]
        movie.save
      rescue  Exception => e

      end

    end  
   
  end

  def get_detail(url)
    begin
      # timeout(10) do
      # @doc = Nokogiri::HTML(open("http://www.7k7kk.org#{url}"), nil, "gb2312")
      # @doc = Nokogiri::HTML(open("http://www.7k7kk.org/film/info/-12507-.html"), nil, "gb2312")
      # end

      html = open("http://www.7k7kk.org#{url}").read
      html.force_encoding("gbk")
      html.encode!("utf-8")
      @doc = Nokogiri::HTML.parse html

    rescue Errno::ECONNRESET => e
      # retry unless count++ > 10
      # puts "tried 10 times and couldn't get #{url}: #{e}"
    end  
    
    str =  @doc.css(".info_js i").text().split("演员：")[0].slice(3,100)  # 爱情 韩国 韩语 2010年

    # binding.pry
    
    puts str.split(" ")[0]  # :category_ids

    category_ids = str.split(" ")[0]
    if category_ids == "动作"
      category_ids = ["513bada26dd5050200000001"]
    elsif category_ids == "爱情"
      category_ids = ["513badb66dd5050200000002"]
    elsif category_ids == "喜剧"
      category_ids = ["513bae306dd5050200000003"]
    elsif category_ids == "恐怖"
      category_ids = ["513bae496dd5050200000004"]
    elsif category_ids == "科幻"
      category_ids = ["513bae646dd5050200000005"]
    elsif category_ids == "剧情"
      category_ids = ["513bf57b2eace70200000003"]      
    elsif category_ids == "魔幻"
      category_ids = ["513bf5932eace70200000004"]
    elsif category_ids == "战争"
      category_ids = ["5158fc881da19ce933000006"]
    elsif category_ids == "纪录"
      category_ids = ["5166824f263da4a9e9000001"]      
    elsif category_ids == "综艺"
      category_ids = ["51668270263da4a9e9000002"]
    elsif category_ids == "动漫"
      category_ids = ["51668286263da4a9e9000003"]  
    else
      category_ids = []
    end  

    puts @doc.css(".info_js i").text().split("演员：")[1].to_s  # :actor 演员

    videos = []
    @doc.css(".info_list a").each do |item|
      puts item.text()  # :name
      puts item.attr('href') 

      # 输出不完整，可能是页面结构有问题，换用Net::HTTP
      # @doc_1 = Nokogiri::HTML(open("http://www.7k7kk.org#{item.attr('href')}"), nil, "gb2312") 

      # uri = URI("http://www.7k7kk.org#{item.attr('href')}")
      # @doc_1 = Net::HTTP.get(uri)  # => String

      uri = URI("http://www.7k7kk.org#{item.attr('href')}")
      html = Net::HTTP.get(uri)  # => String
      html.force_encoding("gbk")
      html.encode!("utf-8")
      @doc_1 = Nokogiri::HTML.parse html

      md = /BdPlayer\['url'\] = '(.*)';/.match(@doc_1)

      # binding.pry if item.attr('href') == "/film/play/-3511-1-.html"
      # binding.pry unless md

      puts md[0]
      puts md[1]    # :link
      video = {}
      video[:name] = item.text()  # :name
      video[:link] = (md[1] ||= "")         # :link
      videos << video
     
    end  

    # puts @doc.css(".info_js").text();  # :intro

    # f = File.open("aaa.txt","a") 
    # f.puts (@doc.css(".info_js").to_html().split('<br>').last)
    {
      :area => str.split(" ")[1] ||= "" , 
      :actor => @doc.css(".info_js i").text().split("演员：")[1].to_s, 
      :release => str.split(" ")[3],
      :intro => @doc.css(".info_js").text(),
      :category_ids => category_ids, 
      :baiduvideos_attributes => videos
    }
  end

  def test_luanma
      # @doc = Nokogiri::HTML(open("http://www.7k7kk.org/film/play/-3511-1-.html"), nil, "gb2312") 

      # uri = URI("http://www.7k7kk.org/film/play/-3511-1-.html")
      # html = Net::HTTP.get(uri)  # => String

      html = open("http://www.fiet.gov.cn/ar/20130220257522.htm").read
      puts html.encoding
      
      binding.pry
      
      # html.force_encoding("gbk")
      html.encode!("utf-8")

      # html.encode!("utf-8", :undef => :replace, :replace => "?", :invalid => :replace)

      binding.pry
  end

  def download_img(page)
    begin
      html = open("http://www.7k7kk.org/film/class/-24-0-0-0-#{page}-0-1_2_3_4_5_6_7_8_9_10-.html").read
      html.force_encoding("gbk")
      html.encode!("utf-8")
      @doc = Nokogiri::HTML.parse html

      @doc.css(".yi_c ul li:first a").each do |item|
        # puts item.attr('title') # :name
        src = item.css('img').attr('src').to_s # :pic
        dir = src.to_s.split('/').last(2).first
        # binding.pry
        Dir.mkdir("img/#{dir}") unless File.directory?("img/#{dir}")
        open(src) { |f|
          File.open(File.join("img", dir, src.to_s.split('/').last), "wb") do |file|
            file.puts f.read
          end
        }
      end  

    rescue Exception => e

    end  

  end

  def download_all_img
    (1..805).to_a.reverse.select {|x| download_img(x) }
  end
  
end


class Bdzy

  def initialize()
    
  end

  def get_all
    (1..5).to_a.reverse.select {|x| get_urls(x) }
  end

  def get_urls(page)
    
    html = open("http://www.bdzy.cc/list/?0-#{page}.html").read
    html.force_encoding("gbk")
    @doc = Nokogiri::HTML.parse html

    begin
      
    @doc.css("table:eq(2) a").each do |item|
      movie_name = item.text().split("[")[0].chop  #去掉末尾的&nbsp
      url = item.attr("href")

      movie = get_detail(url)
      # movie = get_detail("detail/?17804.html")

      if movie == false
        next
      end

      puts movie[:name]
      
      # movies = Movie.where(:name => /#{movie[:name].gsub("(", "\\(").gsub(")", "\\)")}/)
      # movies = Movie.where(:name => movie_name)
      movies = Movie.where(:name => movie[:name])
      # Movie.where(:name => /钟无艳\(电影\)/)

      if movies.count == 1
        # next

        # movies.first.update_attributes(
        #   :name => "lian cheng", 
        #   :pic => "lc1.gif", 
        #   :baiduvideos_attributes => [
        #     {:name => "one ji", :link => "1.avi"},
        #     {:name => "two ji", :link => "2.avi"}
        #   ]
        # )
        
        movies.first.baiduvideos = nil
        # binding.pry
        movies.first.update_attributes(movie)
        
      elsif movies.count == 0

        # movies.create(
        #   :name => "lian cheng", 
        #   :pic => "lc1.gif", 
        #   :baiduvideos_attributes => [
        #     {:name => "one ji", :link => "1.avi"},
        #     {:name => "two ji", :link => "2.avi"}
        #   ]
        # )
        # binding.pry
        Movie.create(movie)
      else
        next
      end 

    end  

    rescue Exception => e
      
    end
  end

  def get_detail(url)
    html = open("http://www.bdzy.cc/#{url}").read
    # html = open("http://www.bdzy.cc/detail/?15281.html").read
    html.force_encoding("gbk")
    # html.encode!("utf-8", :undef => :replace, :replace => "?", :invalid => :replace)
    html.encode!("utf-8")
    # html = (Nokogiri::HTML.parse html).to_s
    @doc = Nokogiri::HTML.parse html

    md = /<!--影片名称开始代码-->([\s\S\r\n\.]*?)<!--影片名称结束代码-->/.match(html)
    name = md[1].strip    # name

    md = /<!--影片类型开始代码-->([\s\S\r\n\.]*?)<!--影片类型结束代码-->/.match(html)
    category_ids = md[1].chomp   # category_ids

    md = /<!--影片演员开始代码-->([\s\S\r\n\.]*?)<!--影片演员结束代码-->/.match(html)
    actor = md[1]  # actor

    md = /<!--影片备注开始代码-->([\s\S\r\n\.]*?)<!--影片备注结束代码-->/.match(html)
    bz = md[1]  # bz

    md = /<!--影片地区开始代码-->([\s\S\r\n\.]*?)<!--影片地区结束代码-->/.match(html)
    area = md[1]  # area

    md = /<!--影片更新时间开始代码-->([\s\S\r\n\.]*?)<!--影片更新时间结束代码-->/.match(html)
    # puts md[1]  # updated_at

    md = /<!--影片状态开始代码-->([\s\S\r\n\.]*?)<!--影片状态结束代码-->/.match(html)
    status = md[1]  # status

    md = /<!--影片图片开始代码-->([\s\S\r\n\.]*?)<!--影片图片结束代码-->/.match(html)
    # binding.pry
    pic = md[1]     # pic

    md = /<!--影片语言开始代码-->([\s\S\r\n\.]*?)<!--影片语言结束代码-->/.match(html)
    language = md[1]  # language
    
    md = /<!--上映日期开始代码-->([\s\S\r\n\.]*?)<!--上映日期结束代码-->/.match(html)
    release = md[1]  # release

    md = /<!--影片介绍开始代码-->([\s\S\r\n\.]*?)<!--影片介绍结束代码-->/.match(html)
    intro = md[1]  # intro
    # intro = @doc.css(".intro").text

    videos = [] # baiduvideos
    @doc.css(".bt li input[type='checkbox']").each do |item|
      video = {}
      name_1 = item.attr("value").split('|').last
      video[:name] = name_1.slice(0, name_1.rindex(".")|| 100  )       # :name
      video[:link] = item.attr("value")              # :link
      videos << video 
    end  

    if  /电视剧/ =~ category_ids
      return false
    end  

    if category_ids == "动作片"
      category_ids = ["513bada26dd5050200000001"]
    elsif category_ids == "爱情片"
      category_ids = ["513badb66dd5050200000002"]
    elsif category_ids == "喜剧片"
      category_ids = ["513bae306dd5050200000003"]
    elsif category_ids == "恐怖片"
      category_ids = ["513bae496dd5050200000004"]
    elsif category_ids == "科幻片"
      category_ids = ["513bae646dd5050200000005"]
    elsif category_ids == "剧情片"
      category_ids = ["513bf57b2eace70200000003"]      
    elsif category_ids == "魔幻片"
      category_ids = ["513bf5932eace70200000004"]
    elsif category_ids == "战争片"
      category_ids = ["5158fc881da19ce933000006"]
    elsif category_ids == "纪录片"
      category_ids = ["5166824f263da4a9e9000001"]      
    elsif category_ids == "综艺节目"
      category_ids = ["51668270263da4a9e9000002"]
    elsif category_ids == "卡通动漫"
      category_ids = ["51668286263da4a9e9000003"]  
    else
      category_ids = []
    end  

    {
      :name => name,
      :actor => actor, 
      :bz => bz,
      :pic => pic,
      :area => area,
      :status => status, 
      :language => language,
      :release => release,
      :intro => intro,
      :category_ids => category_ids,
      :baiduvideos_attributes => videos
    }
  end

end  

# get_urls(1)
# get_detail(1)

# contents = File.read('test1.txt', :encoding => 'utf-8')
# md = /BdPlayer\['url'\] = '(.*)';/.match(contents)
# puts md[0]
# puts md[1]

# puts "爱情 韩国 韩语 2010年".split(" ").inspect
# puts "爱情 韩国 韩语 年".split(" ").last.delete("年")







def download_img_from_local(src)

  # src = "http://pic.8888fy.com/pic/uploadimg/2012-7/4881.jpg"
  return unless src =~ /http:/

  path = URI(src).path[1..-1]   # 去掉靠头的 '/'

  # File.dirname("/home/gumby/work/ruby.rb")   #=> "/home/gumby/work"
  dir = File.dirname(path)

  # arr = path.split('/')
  # arr.shift
  # arr.pop
  # dir = arr.join('/')

  # binding.pry
  # Dir.mkdir("img/#{dir}") unless File.directory?("img/#{dir}")
  FileUtils.mkdir_p("img/#{dir}") unless File.directory?("img/#{dir}")

  unless File.exist?("img/#{path}")
    begin
      puts "downloading...#{src}...";
      open(src) { |f|
        File.open("img/#{path}", "wb") do |file|
          file.puts f.read
        end
      }  
    rescue Exception => e
      puts "couldn't get #{src}: #{e}"
    end
  end
  
end

