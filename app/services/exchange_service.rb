require 'rest-client'
require 'json'
 
class ExchangeService
  def initialize(source_currency, target_currency, amount)
    @source_currency = source_currency
    @target_currency = target_currency
    @amount = amount.to_f
  end
 
 
  def perform
    begin
      if @source_currency == 'BTC' || @target_currency == 'BTC'
        perform_bitcoin
      else
        exchange_api_url = Rails.application.credentials[Rails.env.to_sym][:currency_api_url]
        exchange_api_key = Rails.application.credentials[Rails.env.to_sym][:currency_api_key]
        url = "#{exchange_api_url}?token=#{exchange_api_key}&currency=#{@source_currency}/#{@target_currency}"
        res = RestClient.get url
        value = JSON.parse(res.body)['currency'][0]['value'].to_f
        
        value * @amount
      end
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

  def perform_bitcoin
    url_bitcoin = "https://blockchain.info/ticker"
    res_bitcoin = RestClient.get url_bitcoin

    currency = get_currency(@source_currency, @target_currency)
    value = JSON.parse(res_bitcoin.body)["#{currency}"]['last'].to_f

    final_value = get_final_value(@source_currency, @target_currency, value)
  end

  def get_currency(source_currency, target_currency)
    if source_currency == 'BTC'
      return target_currency
    else
      return source_currency
    end
  end

  def get_final_value(source_currency, target_currency, value)
    if target_currency == 'BTC'
      return @amount / value
    else
      return value * @amount
    end
  end

end