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
    doc = self.get_page(profile_url)
    socials = doc.css(".social-icon-container")
    links = {}
    socials.each do |site|
      ind_site = site.css("a").attribute("href").text
      print ind_site
      if ind_site.include?("twitter")
        links[:twitter] = ind_site
      elsif ind_site.include?("linkedin")
        links[:linkedin] = ind_site
      elsif ind_site.include?("github")
        links[:github] = ind_site
      else
        links[:blog] = ind_site
      end
    end
    links[:profile_quote] = doc.css(".profile-quote").text
    links[:bio] = doc.css(".description-holder p").text
    links

  end

end


Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/")
