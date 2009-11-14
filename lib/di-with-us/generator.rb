require 'httparty'
require 'pp'

module DIWithUs
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
        result = HTTParty.get("#{THESAURUS_URL}/#{@api_key}/#{URI.encode(word)}/json")
        result.to_a.shuffle.first[1]['syn'].shuffle.first.split.map { |str| str.capitalize }.join(' ')
      }.join(' ')
    end
  end
end
