require 'rails_helper'

RSpec.describe ExchangesHelper, type: :helper do

  describe 'Currency list' do
    it 'check if list has value' do

      expect(currency_list).not_to be_empty
    end
  end
  
end
