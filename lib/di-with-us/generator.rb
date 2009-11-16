require 'rubygems'

gem 'httparty', '= 0.4.3'
require 'httparty'

# look don't worry about it
class Array
  def give_me_a_random_element
    self[rand(size)]
  end
end

module DiWithUs
  class Generator
    VENUES = 
      ['Arctic Circle',
       'Full Tilt Ice Cream',
       'Fusion Cafe',
       'The Green House',
       'Ground Zero Teen Center',
       'Healthy Times Fun Club',
       'The Morgue',
       'The Office of Doctor Glorious',
       'The Old Fire House',
       'Pilot Books',
       'Squid and Ink',
       'Wayward Cafe']
    IGNORE = Set['the', 'of', 'and']
    THESAURUS_URL = 'http://words.bighugelabs.com/api/2'
    API_KEY = YAML.load(File.read(
      File.join(
        File.dirname(__FILE__),
        '..',
        '..',
        'config',
        'big-huge-thesaurus.yml')))['api_key']

    def self.generate
      v = VENUES.give_me_a_random_element
      v.split.map { |word|
        next word if IGNORE.include? word.downcase
        url = "#{THESAURUS_URL}/#{API_KEY}/#{URI.encode(word)}/json"
        r = HTTParty.get(url)
        r.to_a.give_me_a_random_element[1]['syn'].give_me_a_random_element.split.map { |str| str.capitalize }.join(' ')
      }.join(' ') + " (via #{v})"
    end
  end
end
