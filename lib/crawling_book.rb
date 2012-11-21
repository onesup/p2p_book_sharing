# coding : utf-8

#How to run: just type in console, 'CrawlingBook.start'

# 희귀사례 테스트용 url 
# http://book.daum.net/detail/book.do?bookid=BOK00009259809YO
# 책 크기 정보 없음. 책 소개 없음.
# http://book.daum.net/detail/book.do?bookid=BOK00008912179BA
# isbn, 책 크기 정보 없음.
# http://book.daum.net/detail/book.do?bookid=KOR2005723000625
# isbn 10만 없음.
# http://book.daum.net/detail/book.do?bookid=KOR9788906035555
# 해당 책 정보는 제한되었습니다.
# http://book.daum.net/detail/book.do?bookid=BOK00003309287IN

require 'open-uri'

class CrawlingBook
  attr_reader :categories

  def self.put_item(item)
    i = Book.new
    i.url = item[:url]
    i.title	= item[:title]
    i.foreign_title = item[:foreign_title]
    i.first_category	= item[:first_category]
    i.second_category	= item[:second_category]
    i.authors	= item[:author]
    i.main_author = item[:author].first
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
  
  def self.get_list(doc, nav_info = {})
    list = Array.new    
    doc.xpath('//div[@id="page_body"]//ul[@class="listType"]//li/dl/dt/a').each do |book|
      list << {:url => book["href"], :title => book.text}
    end
    nav_info[:page] = nav_info[:page] + 1
    #매 10 페이지 다음 페이지마다 pageAction 이 1로 변경.
    nav_info[:page_action] = (nav_info[:page] - 1) % 10 == 0 ? 1 : 0 
    nav_info[:min_value] = doc.xpath('//input[@id="minValue"]').first["value"].strip
    nav_info[:max_value] = doc.xpath('//input[@id="maxValue"]').first["value"].strip
    doc.xpath('//div[@id="page_body"]//ul[@class="listType"]//li/dl/dt/a').each do |book|
      unless BookUrl.exists?(:url => book["href"])
        b = BookUrl.new
        b.url = book["href"]
        b.title = book.text
        b.save
      else
        puts "skip"
      end
    end
    nav_info
  end
  
  def self.get_list_doc(nav_info = {})
    nav_info[:page] ||= 1 
    nav_info[:page_action] ||= 0
    nav_info[:max_value] ||= nil
    nav_info[:min_value] ||= nil
    nav_info[:category] ||= "KOR01"
    nav_info[:last_page] ||= 3
    url = "http://book.daum.net/category/book.do?cTab=06&disrate=0&sortType=1&recentType=0&viewType=01&saleStatus="
    url = url + "&categoryID=" + nav_info[:category]
    url = url + "&pageAction=" + nav_info[:page_action].to_s
    unless nav_info[:max_value].nil?
      url = url + "&maxValue=" + nav_info[:max_value] + "&minValue=" + nav_info[:min_value]
    else
      url = url + "&maxValue=&minValue="
    end
    url = url + "&pageNo=" + nav_info[:page].to_s
    begin
      doc = Nokogiri::HTML(open(url))
    rescue
      puts "connection error:::" + url
    end
    doc
  end
  
  def self.get_list_last_page(option = {})
    option[:category] ||= "KOR01"
    url = "http://book.daum.net/category/book.do?cTab=06&disrate=&sortType=1&recentType=0&viewType=01&saleStatus="
    url += "&categoryID=" + option[:category]
    doc = Nokogiri::HTML(open(url))
    last_page = doc.xpath('//div[@id="pagingBook"]/span//em').last.text
    last_page = last_page.split(',').join.to_i #3,019를 3019로 만들기.
    # latest_date = doc.xpath('//span[@class="date"]').first
    # latest_date = latest_date.text.to_date 
    last_page
  end
  
  def self.parse_item(url)
    url = "http://book.daum.net" + url
    item = Hash.new
    begin
      doc = Nokogiri::HTML(open(url))
      if doc.xpath('//div[@id="error_content"]').empty? == true
        authors = Array.new
        reviewed = 0    
        doc.xpath('//dd[@id="author_info"]//a').each{|x| authors << x.text.strip}
        doc.xpath('//a[@class="quote_num"]').each{|x| reviewed = reviewed + x.text.to_i}
        item[:url] = url
        item[:author] = authors
        item[:reviewed] = reviewed
        item[:title] = doc.xpath('//div[@id="page_body"]//h2[@class="title"]/span').first.text
        item[:series] = doc.xpath('//div[@id="page_body"]//h2[@class="title"]/span').last.text
        item[:language] = doc.xpath('//div[@id="page_body"]//div[@class="selectLay"]//strong')[0].text.strip
        item[:first_category] = doc.xpath('//div[@id="page_body"]//div[@class="selectLay"]//strong')[1].text.strip
        if doc.xpath('//div[@id="page_body"]//div[@class="selectLay"]//strong')[2].nil?
          item[:second_category] = nil
        else
          item[:second_category] = doc.xpath('//div[@id="page_body"]//div[@class="selectLay"]//strong')[2].text.strip
        end
        item[:publisher] = doc.xpath('//dd[@id="publisher_info"]//a').text.strip
        item[:published_at] = doc.xpath('//dd[@id="publisher_info"]').children[4].text.strip.to_date
        if doc.xpath('//div[@id="page_body"]/div[@class="topContWrap"]/div[@class="bookInfoArea"]/dl[@class="info"]//dd').count == 5
          item[:size] = doc.xpath('//div[@id="page_body"]/div[@class="topContWrap"]/div[@class="bookInfoArea"]/dl[@class="info"]//dd')[2].children[0].text.strip
          if item[:last_page] = doc.xpath('//div[@id="page_body"]/div[@class="topContWrap"]/div[@class="bookInfoArea"]/dl[@class="info"]//dd')[2].count == 0
            item[:last_page] = doc.xpath('//div[@id="page_body"]/div[@class="topContWrap"]/div[@class="bookInfoArea"]/dl[@class="info"]//dd')[2].text.strip
          else
            item[:last_page] = doc.xpath('//div[@id="page_body"]/div[@class="topContWrap"]/div[@class="bookInfoArea"]/dl[@class="info"]//dd')[2].children[2].text.strip
          end
        else
          item[:size] = doc.xpath('//div[@id="page_body"]/div[@class="topContWrap"]/div[@class="bookInfoArea"]/dl[@class="info"]//dd')[3].children[0].text.strip
          if doc.xpath('//div[@id="page_body"]/div[@class="topContWrap"]/div[@class="bookInfoArea"]/dl[@class="info"]//dd')[3].count == 0
            item[:last_page] = doc.xpath('//div[@id="page_body"]/div[@class="topContWrap"]/div[@class="bookInfoArea"]/dl[@class="info"]//dd')[3].text.strip
          else
            item[:last_page] = doc.xpath('//div[@id="page_body"]/div[@class="topContWrap"]/div[@class="bookInfoArea"]/dl[@class="info"]//dd')[2].children[2].text.strip
          end
        end
        if doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').children.count == 3 #한국 책
          item[:isbn10] = doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').children[0].text.strip
          item[:isbn13] = doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').children[2].text.strip
        else #원제가 있는 번역 책
          if doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').children[0].nil?
            item[:foreign_title] = nil
          else
            item[:foreign_title] = doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').children[0].text.strip
          end
          if doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').count == 1
            item[:isbn10] = doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').text.strip
            item[:isbn13] = doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').text.strip
          else
            if doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').children[2].nil?
              item[:isbn10] = nil
            else
              item[:isbn10] = doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').children[2].text.strip
            end
            if doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').empty?
              item[:isbn13] = nil
            else
              item[:isbn13] = doc.xpath('//div[@id="etc_info"]//div[@class="textWrap"]').children[4].text.strip
            end
          end
        end
        item[:price] = doc.xpath('//dd[@id="price_info"]//strike').text
        item[:price] = /-?\d+(,?\d*)*\.?\d*/.match(item[:price])[0].to_i if item[:price].kind_of?(Array)
        if doc.xpath('//div[@id="page_body"]//div[@class="introd"]/dl/dd').empty?
          item[:description] = nil
        else
          item[:description] = doc.xpath('//div[@id="page_body"]//div[@class="introd"]/dl/dd').children[2..7].text.strip
        end
        item[:index] = doc.xpath('//div[@id="page_body"]//div[@class="book_table"]//div').text.strip
      end
    rescue URI::InvalidURIError
      item[:url] = url
    end
    item
  end
  
  def self.test
    category = "KOR01"
    last_page = CrawlingBook.get_list_last_page(:category => category)
    nav_info = {:page => 1, :last_page => last_page, :category => category}
    doc = CrawlingBook.get_list_doc(nav_info)
    nav_info = CrawlingBook.get_list(doc, nav_info)
    nav_info
  end
        
  def self.start
    code = "KOR13"
    CrawlingBook.url_start(code)
  end
  
  def self.url_start(code)
    start_time = Time.now
    last_page = CrawlingBook.get_list_last_page(:category => code)
    nav_info = {:page => 1, :last_page => last_page + 1, :category => code}
    last_page.times do |p|
      puts p.to_s + "/" + last_page.to_s
      doc = CrawlingBook.get_list_doc(nav_info)
      nav_info = CrawlingBook.get_list(doc, nav_info)
    end
  end
  
  def self.book_start(start_record = nil)
    start_record ||= 500000 #350445
    n_count = 0
    BookUrl.find(:all, :limit => 100, :offset => n_count) do |i|
      if i.id > start_record
        puts i.id
        unless Book.exists?(:url => "http://book.daum.net" + i.url)
          puts i.id
          book = CrawlingBook.parse_item(i.url)
          CrawlingBook.put_item(book)
        end
      end
      n_count += 100
    end
  end
  
  def self.categories
    [
      {:name => "독일 소설", :code => "KOR0112"} #for test. that category has just 87pages.
      
      # {:name => "소설", :code => "KOR01"}, v
      # {:name => "시·에세이", :code => "KOR03"}, v
      # {:name => "경제·경영", :code => "KOR13"}, v
      # {:name => "자기계발", :code => "KOR15"}, v
      # 
      # {:name => "유아", :code => "KOR41"}, v
      # {:name => "아동", :code => "KOR42"}, v
      # {:name => "중·고 학습", :code => "KOR25"}, v
      # {:name => "어린이영어", :code => "KOR45"}, v
      
      # {:name => "초등학습", :code => "KOR39"},
      # {:name => "청소년", :code => "KOR38"},
      # {:name => "취업·수험서", :code => "KOR31"},
      # {:name => "가정·생활", :code => "KOR07"},
      
      # {:name => "예술·대중문화", :code => "KOR23"},
      # {:name => "취미·스포츠", :code => "KOR11"},
      # {:name => "요리", :code => "KOR08"},
      # {:name => "건강", :code => "KOR09"},
      
      # {:name => "여행", :code => "KOR32"},
      # {:name => "외국어", :code => "KOR27"},      
      # {:name => "사전", :code => "KOR37"},
      # {:name => "잡지", :code => "KOR35"},
      
      # {:name => "만화", :code => "KOR47"}, 2012. 11. 7
      # {:name => "인문", :code => "KOR05"}, 2012. 11. 7
      # {:name => "종교", :code => "KOR21"}, 2012. 11. 7
      # {:name => "정치사회", :code => "KOR17"}, 2012. 11. 7     
      
      # {:name => "역사문화", :code => "KOR19"},
      # {:name => "과학", :code => "KOR29"},
      # {:name => "기술·공학", :code => "KOR26"},
      # {:name => "컴퓨터·IT", :code => "KOR33"},
      
      # {:name => "영어도서", :code => "ENG"},
      # {:name => "일본도서", :code => "JAP"}
    ]
  end

end
