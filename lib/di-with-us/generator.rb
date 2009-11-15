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
    VENUE = %w[Healthy Times Fun Club]
    THESAURUS_URL = 'http://words.bighugelabs.com/api/2'
    API_KEY = YAML.load(File.read(
      File.join(
        File.dirname(__FILE__),
        '..',
        '..',
        'config',
        'big-huge-thesaurus.yml')))['api-key']

    def self.generate
      VENUE.map { |word|
        r = HTTParty.get("#{THESAURUS_URL}/#{API_KEY}/#{URI.encode(word)}/json")
        r.to_a.shuffle.first[1]['syn'].give_me_a_random_element.split.map { |str| str.capitalize }.join(' ')
      }.join(' ')
    end
  end
end
