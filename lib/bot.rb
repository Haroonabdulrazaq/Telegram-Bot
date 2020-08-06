require 'telegram/bot'
require_relative 'exchange.rb'
require_relative '../helper/message.rb'
require 'dotenv'
Dotenv.load
# Exchange Bot Class
class ExchangeBot
  def initialize
    @token = ENV['BOT_TOKEN']
    init_bot
  end

  private

  def init_bot
    Telegram::Bot::Client.run(@token) do |bot|
      bot_commands(bot)
    end
  end

  def bot_commands(bot)
    exchanger = Exchange.new
    explore_arr = []
    bot.listen do |message|
      case message.text
      when '/start'
        bot.api.send_message(chat_id: message.chat.id,
                             text: "Hi there #{message.from.first_name}," << Message::WELCOME_MESSAGE)
      when '/commands'
        bot.api.send_message(chat_id: message.chat.id, text: Message::VALID_COMMANDS)
      when '/explore'
        whole_obj = exchanger.make_request['currency_rates']
        whole_obj.each do |key, i|
          break if i == 30

          explore_arr << " #{key} "
        end
        bot.api.send_message(chat_id: message.chat.id, text: explore_arr.to_s)
      when '/formula'
        formula = exchanger.make_request['formula']
        bot.api.send_message(chat_id: message.chat.id, text: Message::FORMULA1 << " #{formula}" << Message::FORMULA2)
      when /usd-([a-z]{3})/i
        users_query = message.text
        if users_query.include?('-')
          valid_input = users_query.split('-')
          currency_rate = exchanger.make_request['currency_rates']
          usd_rate = currency_rate[valid_input[0].upcase].to_f
          eur_rate = currency_rate[valid_input[1].upcase].to_f
          if usd_rate != 0 && eur_rate != 0
            calculation = usd_rate / eur_rate
            bot.api.send_message(chat_id: message.chat.id,
                                 text: "1 #{valid_input[0]} equals #{calculation} #{valid_input[1]}")
            bot.api.send_message(chat_id: message.chat.id,
                                 text: "#{valid_input[0]} to #{valid_input[1]} rate is, #{usd_rate} - #{eur_rate}")
          else
            bot.api.send_message(chat_id: message.chat.id, text: Message::WARNING_MESSAGE)
          end
        end
      when '/stop'
        bot.api.send_message(chat_id: message.chat.id, text: Message::BYE_MESSAGE << " #{message.from.first_name}")
      else
        bot.api.send_message(chat_id: message.chat.id, text: Message::WARNING_MESSAGE)
      end
    end
  end
end
