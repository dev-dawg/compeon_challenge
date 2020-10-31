require 'spec_helper'

RSpec.describe'Coding Challenge', :aggregate_failures do
  describe 'send_sms_message' do
    before do
      allow(SMS_CARRIER).to receive(:deliver_message).and_return(true)
    end

    it 'calls the SMS Carrier' do
      send_sms_message('hello from Compeon', 'hello@you.de', 'compeon@compeon.de')

      expect(SMS_CARRIER).to have_received(:deliver_message)
    end

    context 'when the text has more than 160 characters' do
      it 'splits the text and sends it separately' do
        text = 'a' * 165
        send_sms_message(text, 'hello@you.de', 'compeon@compeon.de')

        expect(SMS_CARRIER).to have_received(:deliver_message).twice
      end
    end
  end
end
