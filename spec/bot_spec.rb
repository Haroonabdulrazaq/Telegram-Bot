# frozen_string_literal: true

require_relative '../lib/bot.rb'
require_relative '../lib/exchange.rb'

describe '#Exchange' do
  let(:exchange) { Exchange.new }
  describe '#make_request' do
    it 'should return an hash parsed by the API' do
      expect(exchange.make_request.class).to eql(Hash)
    end
  end
end

describe '#ExchangeBot' do
  let(:currency) { ExchangeBot.new }
  describe '#bot_Commands' do
    it 'returns the same value as the bot' do
      expect(currency.bot_commands).to eql(Bot)
    end
  end
end
