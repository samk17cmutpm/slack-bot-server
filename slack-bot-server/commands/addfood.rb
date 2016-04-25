module SlackBotServer
  module Commands
    class AddFood < SlackRubyBot::Commands::Base
      def self.call(client, data, match)
        team_id = data.team
        food_name = match['expression']
        if food_name.blank?
          client.say(channel: data.channel, text: "hi <@#{data.user}>, you should command like this addfood Noodle to add Noodle to the menu")
        else
          food_temp = { :name => food_name, :team_id => team_id}
          food = Food.new(food_temp)
          food.save
          logger.info "#{Food.all.to_json}"
          client.say(channel: data.channel, text: "Thanks, you have added #{food_name} to the menu successfully ")
        end
      end
    end

    class RemoveFood < SlackRubyBot::Commands::Base
      def self.call(client, data, match)
        Food.delete_all
        logger.info "#{Food.all.to_json}"
        client.say(channel: data.channel, text: "#{Food.all.to_json}")
      end
    end

    class RemoveProduction < SlackRubyBot::Commands::Base
      def self.call(client, data, match)
        Available.delete_all
        Order.delete_all
        Team.delete_all
        Food.delete_all
      end
    end
  end
end
