ENV['RACK_ENV'] ||= 'development'
ENV['SLACK_CLIENT_ID']='17365332036.36192493682'
ENV['SLACK_CLIENT_SECRET']='5357188da16bc0eb987de4fb53e61e97'


require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV']

Dir[File.expand_path('../config/initializers', __FILE__) + '/**/*.rb'].each do |file|
  require file
end

Mongoid.load! File.expand_path('../config/mongoid.yml', __FILE__), ENV['RACK_ENV']

require 'faye/websocket'
require 'slack-ruby-bot'
require 'slack-bot-server/version'
require 'slack-bot-server/info'
require 'slack-bot-server/models'
require 'slack-bot-server/api'
require 'slack-bot-server/app'
require 'slack-bot-server/server'
require 'slack-bot-server/service'
require 'slack-bot-server/commands'

puts 'sam'
# class PongBot < SlackRubyBot::Bot
#   command 'ping' do |client, data, match|
#     client.say(text: 'pong', channel: data.channel)
#   end
# end
#
# PongBot.run
