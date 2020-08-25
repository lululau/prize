require 'rainbow'

module Prize::Commands
  module Info
    class << self
      def db_info
        <<~EOF

        Redis Connection Information:

            Active:    #{color_boolean(Prize::App.redis_client.connected?)}
            Host:      #{Prize::App.options.host || '127.0.0.1'}
            Port:      #{Prize::App.options.port || 6379}
            Password:  #{(Prize::App.options.password || '').gsub(/./, '*')}
            Database:  #{Prize::App.options.db || 0}
        EOF
      end

      def ssh_info
        <<~EOF

        SSH Connection Information:

            Active:     #{color_boolean(Prize::SSHProxy.active?)}
            Host:       #{Prize::App.options.ssh_host}
            Port:       #{Prize::App.options.ssh_port || ''}
            Username:   #{Prize::App.options.ssh_user}
            Password:   #{(Prize::App.options.ssh_password || '').gsub(/./, '*')}
            Local Port: #{Prize::SSHProxy.local_ssh_proxy_port}
        EOF
      end

      private
      def color_boolean(bool)
        if bool
          Rainbow('TRUE').green
        else
          Rainbow('FALSE').red
        end
      end
    end

    Pry.commands.block_command 'inf' do
      puts Info::db_info
      puts Info::ssh_info if Prize::App.options.ssh_host.present?
    end
  end
end
