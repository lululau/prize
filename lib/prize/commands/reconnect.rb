module Prize::Commands
  module Reconnect
    class << self
      def reconnect
        Prize::SSHProxy.reconnect if Prize::App.options.ssh_host.present?
        Prize::App.redis_client.reconnect unless Prize::App.redis_client.connected?
      end

      def reconnect!
        Prize::SSHProxy.reconnect! if Prize::App.options.ssh_host.present?
        Prize::App.redis_client.reconnect
      end
    end

    Pry.commands.block_command 'reconnect' do
      Reconnect.reconnect
    end

    Pry.commands.block_command 'reconnect!' do
      Reconnect.reconnect!
    end
  end
end
