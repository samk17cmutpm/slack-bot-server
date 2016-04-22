module SlackBotServer
  module Commands

    class Choose < SlackRubyBot::Commands::Base

      def self.call(client, data, match)
        team_id = data.team
        available_menu = Available.find_by(:team_id => team_id)
        if !available_menu.available
          order = match['expression'].to_i
          if order.equal?(0)
            client.say(channel: data.channel, text: "sorry <@#{data.user}>,wrong command, you should type like this choose 1")
          else
            foods = Food.all
            food_name = foods.at(order - 1).name
            order_temp = {
              :menu_id => available_menu.menu_id,
              :user_id => available_menu.user_id,
              :food_name => food_name
            }
            order = Order.find_by order_temp
            if !order.equal?(nil)
              order.update(:total => order.total + 1)
            else
              order = Order.new order_temp
              order.save
            end
            puts Order.all.to_json
            client.say(channel: data.channel, text: "<@#{data.user}> choosed #{food_name}")
          end
        else
          client.say(channel: data.channel, text: "Hi <@#{data.user}> !, please command menu first")
        end
      end
    end
  end
end
