require 'uri'
require 'net/http'
require 'openssl'
require 'json'


class Exchange

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

            currency_value["currency_rates"].each do |currency_ratings |
            bot_response "#{currency_ratings[0]} #{currency_ratings[1]} equals 1 USD\n\n"
            bot_response
            end

    end

end

