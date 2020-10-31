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

      it 'adds - Part X of Y to each message' do
        text = 'a' * 165
        to = 'hello@you.de'
        from = 'compeon@compeon.de'

        expected_message_1 = "#{'a' * 160}#{' - Part 1 of 2'}"
        expected_message_2 = "#{'a' * 5}#{' - Part 2 of 2'}"

        send_sms_message(text, to, from)

        expect(SMS_CARRIER).to have_received(:deliver_message).with(expected_message_1, to, from).once
        expect(SMS_CARRIER).to have_received(:deliver_message).with(expected_message_2, to, from).once
      end
    end
  end
end
