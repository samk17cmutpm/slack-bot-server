module SlackBotServer
  module Commands
    class Whoami < SlackRubyBot::Commands::Base
      def self.call(client, data, _match)
        client.say(channel: data.channel, text: "<@#{data.user}>")
        logger.info "UNAME: #{client.owner}, user=#{data.user}"
      end
    end
    class Menu < SlackRubyBot::Commands::Base
      def self.call(client, data, _match)
        foods = Food.all
        welcome = "Hi <@#{data.user}>, This is the menu, Please to choose"
        client.say(channel: data.channel, text: welcome)
        foods.each_with_index do |food, index|
          client.say(channel: data.channel, text: "#{index} : #{food.name}")
        end
      end
    end
  end
end
