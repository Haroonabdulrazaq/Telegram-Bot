require 'uri'
require 'net/http'
require 'openssl'


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
    currency_value = response.body[95..]

    end

end

exchanger = Exchange.new

puts exchanger.get_request