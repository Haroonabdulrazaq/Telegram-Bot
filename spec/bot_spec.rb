# require_relative '../lib/bot.rb'
require 'exchange.rb'


describe "#Exchange" do
let(:exchange) { Exchange.new }
    describe "#get_request" do
        it 'should return an hash parsed by the API' do
            expect(exchange.get_request.class).to eql(Hash)
        end
    end
end