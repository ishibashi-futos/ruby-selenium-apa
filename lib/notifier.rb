require 'bundler/setup'
require 'slack-notifier'

class Notifier 

  def initialize()
    @notifier = Slack::Notifier.new ENV['WEB_HOOK_URL'],
      channel: ENV['TARGET_CHANNNEL'],
      username: ENV['BOT_NAME']
  end

  def send_message(messages)
    @notifier.ping messages
  end

end
