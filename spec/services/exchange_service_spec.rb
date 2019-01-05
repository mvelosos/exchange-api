require 'spec_helper'
require 'json'
require './app/services/exchange_service'
 
describe 'Currency' do

  it 'exchange currency' do
    amount = rand(0..9999)
    res = ExchangeService.new("USD", "BRL", amount).perform
    expect(res.is_a? Numeric).to eql(true)
    expect(res != 0 || amount == 0).to eql(true)
  end

  it 'exchange bitcoin' do
    amount = rand(0..9999)
    res = ExchangeService.new("BTC", "USD", amount).perform
    expect(res.is_a? Numeric).to eql(true)
    expect(res != 0 || amount == 0).to eql(true)
  end

end