require 'rubygems'
require 'twitter'

module DiWithUs
  class Twitter
    def initialize
      @config = YAML.load_file(File.dirname(__FILE__) +
                               "/../../config/twitter.yml")
      httpauth = ::Twitter::HTTPAuth.new(@config['username'],
                                         @config['password'])
      @client = ::Twitter::Base.new(httpauth)
    end

    def update_status(message)
      @client.update(message)
    end

    # Returns nil or an array ['of', 'words']
    def get_last_status_to_a
      statuses = @client.user_timeline
      if statuses.empty?
        nil
      else
        statuses.first.text.strip.split(/\s+/)
      end
    end
  end
end
