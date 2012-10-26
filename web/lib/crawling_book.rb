# coding : utf-8
require 'open-uri'

class CrawlingBook

  #CrawlingBook.start
        
  def self.put_item(item)
    i = Book.new
    i.title	= item[:title]
    i.foreign_title = item[:foreign_title]
    i.first_category	= item[:first_category]
    i.second_category	= item[:second_category]
    i.author	= item[:author]
    i.publisher	= item[:publisher]
    i.published_at	= item[:published_at]
    i.language	= item[:language]
    i.size	= item[:size]
    i.last_page	= item[:last_page]
    i.isbn10	= item[:isbn10]
    i.isbn13	= item[:isbn13]
    i.price	= item[:price]
    i.reviewed	= item[:reviewed]
    i.description	= item[:description]
    i.index	= item[:index]
    i.series = item[:series]   
    i.save
  end
        
  def self.category
    category_list = Array.new
    category_list = [
      {:title => "", :url => "", :author => "", :review_count => ""}
    ]
  end
  
  def self.get_list(page, doc)
    list = Array.new    
    doc.xpath('//div[@id="page_body"]//ul[@class="listType"]//li/dl/dt/a').each do |book|
      list << {:url => book["href"], :title => book.text}
      puts list
    end
    list.each do |l|
      item = CrawlingBook.parse_item(l[:url])
      CrawlingBook.put_item(item)
    end
    nav_info = Hash.new
    page = page + 1
    #매 10 페이지 다음 페이지마다 pageAction 이 1로 변경.
    nav_info[:page_action] = (page - 1) % 10 == 0 ? 1 : 0 
    nav_info[:min_value] = doc.xpath('//input[@id="minValue"]').first["value"]
    nav_info[:max_value] = doc.xpath('//input[@id="maxValue"]').first["value"]
    CrawlingBook.get_list_doc(page, nav_info)
  end
  
  def self.get_list_doc(page, nav_info = {})
    page = 1 if page.nil?
    page_action = nav_info[:page_action].nil? ? 0 : nav_info[:page_action]
    max_value = nav_info[:max_value].nil? ? nil : nav_info[:max_value]
    min_value = nav_info[:min_value].nil? ? nil : nav_info[:min_value]
    puts "****************" + nav_info[:page_action].to_s
    puts "****************" + nav_info[:min_value].to_s
    puts "****************" + nav_info[:max_value].to_s
    url = "http://book.daum.net/category/book.do?cTab=06&disrate=0&sortType=1&recentType=0&viewType=01&saleStatus=1"
    url = url + "&categoryID=KOR01"
    url = url + "&pageAction=" + page_action.to_s
    url = url + "&maxValue=" + max_value.to_s + "&minValue=" + min_value.to_s
    url = url + "&pageNo=" + page.to_s
    puts url
    doc = Nokogiri::HTML(open(url))
    last_page = doc.xpath('//div[@id="pagingBook"]/span//em').last.text
    last_page = last_page.split(',').join.to_i #3,019를 3019로 만들기.
    #최근 수집한 책의 날짜와 책 리스트의 등록일과 비교해서 수집 여부 결정하는 알고리즘 필요.
    latest_date = doc.xpath('//span[@class="date"]').first
    latest_date = latest_date.text.to_date 
    if page <= last_page
      puts "@   @@" + latest_date.to_s + ":" + last_page.to_s + "/" + page.to_s
      CrawlingBook.get_list(page, doc)
    end
  end
  
  def self.parse_item(url)
    url = "http://book.daum.net" + url
    item = Hash.new
    doc = Nokogiri::HTML(open(url))
    authors = Array.new
    reviewed = 0
    begin
      doc.xpath('//dd[@id="author_info"]//a').each{|x| authors << x.text.strip}
      doc.xpath('//a[@class="quote_num"]').each{|x| reviewed = reviewed + x.text.to_i}
      item[:author] = authors
      item[:reviewed] = reviewed
      item[:title] = doc.xpath('//div[@id="page_body"]//h2[@class="title"]/span').first.text
      item[:series] = doc.xpath('//div[@id="page_body"]//h2[@class="title"]/span').last.text
      item[:language] = doc.xpath('//div[@id="page_body"]//div[@class="selectLay"]//strong')[0].text.strip
      item[:first_category] = doc.xpath('//div[@id="page_body"]//div[@class="selectLay"]//strong')[1].text.strip
      item[:second_category] = doc.xpath('//div[@id="page_body"]//div[@class="selectLay"]//strong')[2].text.strip
      item[:publisher] = doc.xpath('//dd[@id="publisher_info"]//a').text.strip
      item[:published_at] = doc.xpath('//dd[@id="publisher_info"]').children[4].text.strip.to_date
      if doc.xpath('//div[@id="page_body"]/div[@class="topContWrap"]/div[@class="bookInfoArea"]/dl[@class="info"]//dd').count == 5
        item[:size] = doc.xpath('//div[@id="page_body"]/div[@class="topContWrap"]/div[@class="bookInfoArea"]/dl[@class="info"]//dd')[2].children[0].text.strip
        item[:last_page] = doc.xpath('//div[@id="page_body"]/div[@class="topContWrap"]/div[@class="bookInfoArea"]/dl[@class="info"]//dd')[2].children[2].text.strip
      else
        item[:size] = doc.xpath('//div[@id="page_body"]/div[@class="topContWrap"]/div[@class="bookInfoArea"]/dl[@class="info"]//dd')[3].children[0].text.strip
        item[:last_page] = doc.xpath('//div[@id="page_body"]/div[@class="topContWrap"]/div[@class="bookInfoArea"]/dl[@class="info"]//dd')[3].children[2].text.strip
      end
        item[:last_page] = /-?\d+(,?\d*)*\.?\d*/.match(item[:last_page])[0].to_i if item[:last_page].kind_of?(Array)
      if doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').children.count == 3 #한국 책
        item[:isbn10] = doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').children[0].text.strip
        item[:isbn13] = doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').children[2].text.strip
      else #원제가 있는 번역 책
        item[:foreign_title] = doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').children[0].text.strip
        item[:isbn10] = doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').children[2].text.strip
        item[:isbn13] = doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').children[4].text.strip
      end
      item[:price] = doc.xpath('//dd[@id="price_info"]//strike').text
      item[:price] = /-?\d+(,?\d*)*\.?\d*/.match(item[:price])[0].to_i if item[:price].kind_of?(Array)
      item[:description] = doc.xpath('//div[@id="page_body"]//div[@class="introd"]/dl/dd').children[2..7].text.strip
      item[:index] = doc.xpath('//div[@id="page_body"]//div[@class="book_table"]//div').text.strip
    rescue NoMethodError
      item[:title] = "19금"
      item[:series] = url
    end
    item
  end
  
  def self.test
    url = "http://book.daum.net/detail/book.do?bookid=KOR9788967257040"
    doc = Nokogiri::HTML(open(url))
  end
        
  def self.start
    CrawlingBook.get_list_doc(2)
  end

end
