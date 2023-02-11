class Notification < ApplicationRecord
  after_create :send_message

  belongs_to :user
  belongs_to :place

  def send_message
    client = Twilio::REST::Client.new
    client.messages.create({
                               from: ENV['+16208328198'],
                               to: '923214574159',
                               body: 'Hello there! This is a test'
                             })
  end
end
