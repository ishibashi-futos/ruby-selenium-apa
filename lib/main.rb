require_relative './driver'
require_relative './notifier'
require 'date'

driver = WebDriver.new

message_hash_data = driver.get_reservation_data

messages = "Execute Date [#{Time.now}]\n"

['2018-12-29', '2018-12-30', '2018-12-31'].each do |date|
  if message_hash_data.fetch(date) == '×'
    messages += "#{date} : ×\n"
  else
    messages += "#{date} : ◯\n"
  end
end

n = Notifier.new

n.send_message(messages)
