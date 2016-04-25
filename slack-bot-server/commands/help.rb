module SlackBotServer
  module Commands
    class Help < SlackRubyBot::Commands::Base
      HELP = <<-EOS
        I am your friendly slack-bot-server, here to help.

        General
        -------

          help               - get this helpful message
          addfood Noodle => This command will add Noodle to the menu
          menu => This command will show all the foods of the menu of your team
          choose 1 => This command will choose the food in the menu following the orders
          finish => If you command menu, you are the only one can use this command, and will show for you a table of which foods are choosen
     EOS
      def self.call(client, data, _match)
        client.say(channel: data.channel, text: [HELP].join("\n"))
        client.say(channel: data.channel, gif: 'help')
      end
    end
  end
end
