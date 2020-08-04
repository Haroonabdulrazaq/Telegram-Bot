require 'uri'
require 'net/http'
require 'openssl'
require 'json'


class Exchange
    attr_accessor :formula
    def initialize 
        @formula = formula
    end

    def get_request
        url = URI("https://currency-value.p.rapidapi.com/global/currency_rates")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-host"] = 'currency-value.p.rapidapi.com'
        request["x-rapidapi-key"] = '5fbec538d7msh9e5378e39f8e570p164c8ajsnf8c7f46f4df4'
        response = http.request(request)
          currency_value = JSON.parse(response.body)
        #  @formula = currency_value["formula"]
    
    end

    def format_response
        bot_response = []
        currencies = get_request
            currencies["currency_rates"].each_with_index do |currency_ratings,i|
             break if i==20
              bot_response <<  "#{currency_ratings[0]} | #{currency_ratings[1]}\n\n"
            end
                return bot_response
    end
end

#   ex = Exchange.new
# puts ex.get_request
# ex.format_response
 