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

  def explorer(explore_arr, bot, message)
    explore_arr = []
    exchanger = Exchange.new
    whole_obj = exchanger.make_request['currency_rates']
    whole_obj.each do |key, i|
      break if i == 30

      explore_arr << key
    end
    bot.api.send_message(chat_id: message.chat.id, text: explore_arr.to_s)
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
  def bot_commands(bot)
    exchanger = Exchange.new
    bot.listen do |message|
      case message.text
      when '/start'
        bot.api.send_message(chat_id: message.chat.id,
                             text: "Hi there #{message.from.first_name}," << Message::WELCOME_MESSAGE)
      when '/commands'
        bot.api.send_message(chat_id: message.chat.id, text: Message::VALID_COMMANDS)
      when '/explore'
        explorer(message.text, bot, message)
      when '/formula'
        formula = exchanger.make_request['formula']
        bot.api.send_message(chat_id: message.chat.id, text: formula.to_s << Message::FORMULA1 << Message::FORMULA2)
      when /usd-([a-z]{3})/i
        calculation(message.text, bot, message)
      when '/stop'
        bot.api.send_message(chat_id: message.chat.id, text: Message::BYE_MESSAGE)
      else
        bot.api.send_message(chat_id: message.chat.id, text: Message::WARNING_MESSAGE)
      end
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength

  def calculation(users_query, bot, message)
    exchanger = Exchange.new
    (return unless users_query.include?('-'))
    valid_input = users_query.split('-')
    currency_rate = exchanger.make_request['currency_rates']
    usd_rate = currency_rate[valid_input[0].upcase].to_f
    eur_rate = currency_rate[valid_input[1].upcase].to_f
    if usd_rate.zero? && eur_rate.zero?
      bot.api.send_message(chat_id: message.chat.id, text: Message::WARNING_MESSAGE)
    else
      calculation = usd_rate / eur_rate
      bot.api.send_message(chat_id: message.chat.id,
                           text: "1 #{valid_input[0]} equals #{calculation} #{valid_input[1]}")
      bot.api.send_message(chat_id: message.chat.id,
                           text: "#{valid_input[0]} to #{valid_input[1]} rate is, #{usd_rate} - #{eur_rate}")
    end
  end
end
