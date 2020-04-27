require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.get_page(url)
    Nokogiri::HTML(open(url))
  end

  def self.scrape_index_page(index_url)
    doc = self.get_page(index_url)
    final = []
    students = doc.css(".student-card")
    #print students
    students.each do |card|
      name = card.css("a .student-name").text
      scraped_student = {:name => name,
      :location => card.css("a .student-location").text,
      :profile_url => card.css("a").attribute("href").text}
      final << scraped_student
    end
    final
  end

  def self.scrape_profile_page(profile_url)

  end

end


Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/")
