require_relative '../lib/bot.rb'
require_relative '../lib/exchange.rb'


describe "#Exchange" do
let(:exchange) { Exchange.new }
    describe "#get_request" do
        it 'should return an hash parsed by the API' do
            expect(exchange.get_request.class).to eql(Hash)
        end
    end
end

describe "#ExchangeBot" do
let(:currency) { ExchangeBot.new }
    describe '#botCommands' do
        it 'returns the same value as the bot' do
            expect(currency.botCommands).to eql(Bot)
        end
    end
end