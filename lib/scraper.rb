require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def get_page(urL)
    Nokogiri::HTML(open(url))
  end

  def self.scrape_index_page(index_url)
    doc = get_page(index_url)
    final = []
    print students = doc.css(".student-class")
  end

  def self.scrape_profile_page(profile_url)

  end

end

Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/")
