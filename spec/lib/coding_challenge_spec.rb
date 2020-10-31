require 'spec_helper'

RSpec.describe'Coding Challenge', :aggregate_failures do
  describe 'send_sms_message' do
    before do
      allow(SMS_CARRIER).to receive(:deliver_message).and_return(true)
    end

    it 'calls the SMS Carrier' do
      send_sms_message('hello', 'you', 'to')

      expect(SMS_CARRIER).to have_received(:deliver_message)
    end
  end
end
