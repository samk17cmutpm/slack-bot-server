module SlackBotServer
  module Commands
    class Finish < SlackRubyBot::Commands::Base

      def self.call(client, data, match)
        team_id = data.team
        available_menu = Available.find_by(:team_id => team_id)
        puts available_menu.user_id
        puts data.user
        if !available_menu.available  # available to command new order
          if available_menu.user_id == data.user # wtf here :p
            # show choosen foods here
            message = "Hi <@#{data.user}>, You have finished the menu "
            client.say(channel: data.channel, text: message)
            available_menu.update(:available => true)
            orders = Order.where(:menu_id => available_menu.menu_id)
            puts orders.to_json
            orders.each do |order|
              client.say(channel: data.channel, text: "#{order.food_name} : #{order.total}")
            end
            client.say(channel: data.channel, text: "Thanks <@#{data.user}> for setting up this menu")
          else
            message = "Sorry <@#{data.user}>, You cannot finish the order, wait for <@#{available_menu.user_id}> to finish this order "
            client.say(channel: data.channel, text: message)
          end
        else
          message = "Sorry <@#{data.user}>, you must command menu first to order something !"
          client.say(channel: data.channel, text: message)
        end

      end

    end
  end
end
