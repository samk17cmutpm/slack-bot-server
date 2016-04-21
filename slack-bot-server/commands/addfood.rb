module SlackBotServer
  module Commands
    class AddFood < SlackRubyBot::Commands::Base
      def self.call(client, data, match)
        food_name = match['expression']
        food_temp = { :name => food_name }
        food = Food.new(food_temp)
        food.save
        logger.info "#{Food.all.to_json}"
        client.say(channel: data.channel, text: "Thanks, you have added food successfully ")
      end
    end

    class RemoveFood < SlackRubyBot::Commands::Base
      def self.call(client, data, match)
        Food.delete_all
        logger.info "#{Food.all.to_json}"
        client.say(channel: data.channel, text: "#{Food.all.to_json}")
      end
    end
  end
end
