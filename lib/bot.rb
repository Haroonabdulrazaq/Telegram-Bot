require 'telegram/bot'
require_relative 'exchange.rb'

class ExchangeBot  
    
    def initialize
        @token = '1156943187:AAE_JHdRfLYEWxUw5R30vYgng_-TONyDMtA'
        init_bot
    end
    
    def init_bot
        Telegram::Bot::Client.run(@token) do |bot|
            botCommands(bot)
        end
    end

    def botCommands(bot)
        bot.listen do |message|
            case message.text
            when '/start'
            bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")               
            when '/exchangebot'
                exchanger = Exchange.new
            bot.api.send_message(chat_id: message.chat.id, text: "The exchange rate for all currency is, #{exchanger.format_response}")
            # when '/calculation'
            # bot.api.send_message(chat_id: message.chat.id, text: "I did this calculation, #{exchanger.get_request.formula}")
            when '/stop'
            bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
            else
              exchanger = Exchange.new
              users_query = message.text 
                if users_query.include?('/')
                    valid_input = users_query.split('/')
                    currency_rate = exchanger.get_request["currency_rates"]
                    usd_rate = currency_rate[valid_input[0].upcase]
                    eur_rate = currency_rate[valid_input[1].upcase]
                    bot.api.send_message(chat_id: message.chat.id, text: "#{valid_input[0]} to #{valid_input[1]} rate is, #{usd_rate}/#{eur_rate}")
                end
            end    
        end
    end
end

ex = ExchangeBot.new
  ex.botCommands