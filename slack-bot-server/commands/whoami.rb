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
        team_id = data.team
        foods = Food.where(:team_id => team_id)
        if foods.empty?

          client.say(channel: data.channel, text: "Hi <@#{data.user}>, your team has not added some food into menu, please add new food by command => addfood hamberger")

        else

          available_menu = Available.find_by(:team_id => team_id)
          if available_menu.equal?(nil)
            available_temp = {
              :team_id => team_id,
              :available => true
            }
            available_menu = Available.new available_temp
            available_menu.save
          end
          if available_menu.available
            token = loop do
              random_token = SecureRandom.urlsafe_base64(nil, false)
              break random_token unless !Available.find_by(:menu_id => random_token).equal?(nil)
            end
            puts token
            available_menu.update(
                :user_id => data.user,
                :available => false,
                :menu_id => token
            )
            welcome = "Hi <@#{data.user}>, This is the menu, Please to choose"
            client.say(channel: data.channel, text: welcome)
          else
            if Time.now - available_menu.updated_at < 6.hours
              say_sorry = 'Some one in your team has ordered, Please wait for her/him to finish, or you can choose the food'
              client.say(channel: data.channel, text: say_sorry)
            else
              message = 'Some one has ordered, but has not finish the menu, so I destroy that menu and this is menu for you to order again '
              client.say(channel: data.channel, text: message)
              token = loop do
                random_token = SecureRandom.urlsafe_base64(nil, false)
                break random_token unless !Available.find_by(:menu_id => random_token).equal?(nil)
              end
              puts token
              available_menu.update(
                  :user_id => data.user,
                  :available => false,
                  :menu_id => token
              )
              welcome = "Hi <@#{data.user}>, This is the menu, Please to choose"
              client.say(channel: data.channel, text: welcome)
            end

          end
          foods.each_with_index do |food, index|
            client.say(channel: data.channel, text: "#{index + 1} : #{food.name}")
          end
        end
      end
    end
  end
end
