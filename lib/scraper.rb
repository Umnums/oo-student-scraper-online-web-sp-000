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
    doc = self.get_page(profile_url)
    ind_site = doc.css(".social-icon-container a")
    links = {}
    # puts "#{socials}"
    ind_site.each do |site|
      puts "#{site}"
      if site.include?("twitter")
        links[:twitter] = site
      elsif site.include?("linkedin")
        links[:linkedin] = site
      elsif site.include?("github")
        links[:github] = site
      else
        links[:blog] = site
      end
    end
    links[:profile_quote] = doc.css(".profile-quote").text
    links[:bio] = doc.css(".description-holder p")
    puts "#{links}"
    links

  end

end


Scraper.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/eric-chu.html")
