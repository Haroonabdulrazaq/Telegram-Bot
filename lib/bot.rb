require 'telegram/bot'
require_relative 'exchange.rb'

class ExchangeBOt
    exchanger = Exchange.new
    def initialize  
        @token = '1156943187:AAE_JHdRfLYEWxUw5R30vYgng_-TONyDMtA'
        init_bot
    end
    
    def init_bot
        Telegram::Bot::Client.run(@token) do |bot|
            botCommands
        end
    end

    def botCommands
        bot.listen do |message|
            case message.text
            when '/start'
            bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
            when '/exchangebot'
            bot.api.send_message(chat_id: message.chat.id, text: "The exchange rate for all currency is, #{exchanger.get_request}")
            when '/stop'
            bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
            end    
        end
    end
end

