require 'open-uri'

class CrawlingVillage

  #CrawlingVillage.start
  #CrawlingVillage.get_images
  #CrawlingVillage.making_item_type_cache

  def self.get_item(url_list)
    items = Array.new
    url_list.each do |url|
      doc 
      doc.xpath('//div[@id="diablo3Main"]//script[1]').each do |s|
        items << CrawlingItem.parse_item(s)
      end
    end
    items
  end
        
  def self.put_item(items)
    items.each do |item|
      unless item.nil?
        i           = DiabloItem.new
        i.item_name = item[:itemname]
        i.item_code = item[:itemcode]
        i.charclass = item[:charclass]
        i.rarity    = item[:rerity]
        i.reqlevel  = item[:reqlevel]
        i.itemtype  = item[:itemtype]
        i.itemslot  = item[:itemslot]
        i.aps       = item[:aps]
        i.sellvalue = item[:sellvalue]
        i.info      = item
        i.save
      end
    end
  end
        
  def self.parse_item(script)
    eval(script.text.gsub(/\s/,'').match(/\{itemcode.+?\}/).to_s)
  end
        
  def self.get_list
    url = "http://realestate.daum.net/maemul/area/1100000/A1A3A4/*/"
    list = Array.new
    doc = Nokogiri::HTML(open(url))
    doc.xpath('//div[@id="leftAgencyBody"]//ul//li//a/text()').each do |a|

        list << a.content

    end
    list
  end
                
  def self.start
    256.times do |i|
      puts "page" + i.to_s
      a = CrawlingItem.put_item(CrawlingItem.get_item(CrawlingItem.get_list(i)))
    end
  end
        
  def self.test
    a = CrawlingItem.get_item(CrawlingItem.get_list(0))
    a.each do |i|
      unless i.nil?
        puts i[:sellvalue].to_s+":"+i[:itemname]
      end
    end
  end
        
  def self.get_images
    DiabloItem.all.each do |i|
      self.get_image(i)
    end
  end
  
  def self.get_image(item)
    p = Photo.new
    p.remote_photo_url = "http://img.inven.co.kr/image_2011/site_image/diablo3/dataninfo/itemicon/" + item.info[:icon] + "_demonhunter_male.png"
    item.photos << p
    item.save
  end

end