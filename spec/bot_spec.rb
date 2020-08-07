require_relative '../lib/exchange.rb'

describe '#Exchange' do
  let(:exchange) { Exchange.new }
  describe '#make_request' do
    it 'should return an hash parsed by the API' do
      expect(exchange.make_request.class).to eql(Hash)
    end
  end

  describe '#make_formula' do
    it 'should return a formula used in calculating the rate of exchange' do
      formulae = '(amount * this.rates[from]) / this.rates[to]'
      expect(exchange.make_formula).to eql(formulae)
    end
  end
end
