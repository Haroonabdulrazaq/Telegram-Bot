require 'telegram/bot'
require_relative 'exchange.rb'
require_relative 'message.rb'

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
            when '/commands'
            bot.api.send_message(chat_id: message.chat.id, text: Message::VALID_COMMANDS)
            when /usd-[a-z]{3}/i
                exchanger = Exchange.new
                users_query = message.text 
                calculation =0
                if users_query.include?('-')
                    valid_input = users_query.split('-')
                    currency_rate = exchanger.get_request["currency_rates"]
                    usd_rate = currency_rate[valid_input[0].upcase].to_f
                    eur_rate = currency_rate[valid_input[1].upcase].to_f 
                    if usd_rate != 0 && eur_rate !=0
                        calculation = usd_rate / eur_rate
                        bot.api.send_message(chat_id: message.chat.id, text: "1 #{valid_input[0]} equals #{calculation} #{valid_input[1]}")
                    end
                    bot.api.send_message(chat_id: message.chat.id, text: "#{valid_input[1]} to #{valid_input[0]} rate is, #{usd_rate} - #{eur_rate}") 
                end
            when '/stop'
            bot.api.send_message(chat_id: message.chat.id, text: Message::BYE_MESSAGE << " #{message.from.first_name}") 
            else
                bot.api.send_message(chat_id: message.chat.id, text: Message::WARNING_MESSAGE)
            end
        end
    end
end
 