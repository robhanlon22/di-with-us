require 'rubygems'

gem 'httparty', '= 0.4.3'
require 'httparty'

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
        'big-huge-thesaurus.yml')))['api-key']

    def self.generate
      v = VENUES.shuffle.first
      v.split.map { |word|
        next word if IGNORE.include? word.downcase
        r = HTTParty.get("#{THESAURUS_URL}/#{API_KEY}/#{URI.encode(word)}/json")
        r.to_a.shuffle.first[1]['syn'].shuffle.first.split.map { |str| str.capitalize }.join(' ')
      }.join(' ') << " (via #{v})"
    end
  end
end
