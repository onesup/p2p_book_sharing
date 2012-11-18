# coding : utf-8
require 'open-uri'

class CrawlingVillage

  #CrawlingVillage.start
        
  def self.put_item(item)
    if item.exists?(:url)
    i         = Village.new
    i.url     = item[:url]
    i.si      = item[:si]
    i.gu      = item[:gu]
    i.dong    = item[:dong]
    i.village = item[:village]
    i.save
    puts i.si + " " + i.gu + " " + i.dong + " " + i.village
  end
        
  def self.sido
    sido_list = Array.new
    sido_list = [
      {:region => "서울시", :url => "/maemul/area/1100000/A1A3A4/*/summary"},
      {:region => "경기", :url => "/maemul/area/1410000/A1A3A4/*/summary"},
      {:region => "인천시", :url => "/maemul/area/1400000/A1A3A4/*/summary"},
      {:region => "부산시", :url => "/maemul/area/1600000/A1A3A4/*/summary"},
      {:region => "대구시", :url => "/maemul/area/1700000/A1A3A4/*/summary"},
      {:region => "대전시", :url => "/maemul/area/1300000/A1A3A4/*/summary"},
      {:region => "울산시", :url => "/maemul/area/1680000/A1A3A4/*/summary"},
      {:region => "광주시", :url => "/maemul/area/1500000/A1A3A4/*/summary"},
      {:region => "세종시", :url => "/maemul/area/1320000/A1A3A4/*/summary"},
      {:region => "충남", :url => "/maemul/area/1310000/A1A3A4/*/summary"},
      {:region => "충북", :url => "/maemul/area/1360000/A1A3A4/*/summary"},
      {:region => "강원", :url => "/maemul/area/1200000/A1A3A4/*/summary"},
      {:region => "경북", :url => "/maemul/area/1710000/A1A3A4/*/summary"},
      {:region => "경남", :url => "/maemul/area/1620000/A1A3A4/*/summary"},
      {:region => "전북", :url => "/maemul/area/1560000/A1A3A4/*/summary"},
      {:region => "전남", :url => "/maemul/area/1510000/A1A3A4/*/summary"},
      {:region => "제주", :url => "/maemul/area/1690000/A1A3A4/*/summary"}
    ]
  end
  
  def self.get_list(region)
    list = Array.new
    url = "http://realestate.daum.net" + region[:url]
    doc = Nokogiri::HTML(open(url))
    doc.xpath('//div[@id="leftAgencyBody"]//ul//li//a').each do |a|
      unless a["href"] == "#"
        list << {:region => a.text, :url => a["href"]}
        # puts list.last[:region]
      end
    end
    list
  end
  
  def self.get_danji_list(region)
    profile = Selenium::WebDriver::Chrome::Profile.new
    profile['download.prompt_for_download'] = false
    profile['download.default_directory'] = "./"
    b = Watir::Browser.new :chrome, :profile => profile
    list = Array.new
    url = "http://realestate.daum.net" + region[:url]
    begin
    b.goto url
    doc = Nokogiri::HTML(b.html)
    if doc.xpath("//ul[@id='danjiListScope']//li[@class='no_data']").empty?
      doc.xpath("//ul[@id='danjiListScope']//li").each do |li|
        list << {
          :region => li.xpath("span[@class='name']/a[@class='name_link']").text,
          :url => li.xpath("span[@class='name']/a[@class='name_link']").first["href"]
        }
      end
    else
      list << {:region => "아파트 없음", :url => ""}
    end
    rescue
      list << {:region => "뭔가 에러 발생", :url => ""}
    end
    b.close
    list
  end
        
  def self.start
    sido_list = CrawlingVillage.sido
    villages = Array.new
    sido_list.each do |sido|
      CrawlingVillage.get_list(sido).each do |gu|
        CrawlingVillage.get_list(gu).each do |dong|
          CrawlingVillage.get_danji_list(dong).each do |village|
            puts sido[:region] + " " + gu[:region]+ " " + dong[:region]+ " " + village[:region]
            village = {
              :si    => sido[:region], 
              :gu   => gu[:region], 
              :dong    => dong[:region], 
              :village => village[:region],
              :url => village[:url]
            }
            CrawlingVillage.put_item(village)
          end
        end
      end
    end
    villages
  end

end