require 'optparse'
require 'ostruct'

module Prize
  class Cli
    class << self
      def start
        parse_options!
        App.new(@options).run!
      end

      def parse_options!
        @options = OpenStruct.new


        OptionParser.new do |opts|
          opts.banner = <<~EOF
          Usage: prize [options]
          EOF

          opts.on('-uURL', '--url=URL', 'Server URL, for a TCP connection: `redis://:[password]@[hostname]:[port]/[db]` (password, port and database are optional), for a unix socket connection: `unix://[path to Redis socket]`. This overrides all other options.') do |url|
            @options.url = url
          end

          opts.on('-hHOST', '--host=HOST', 'Server hostname (default: 127.0.0.1)') do |host|
            @options.host = host
          end

          opts.on('-pPORT', '--port=PORT', 'Server port (default: 6379)') do |port|
            @options.port = port.to_i
          end

          opts.on('-sPATH', '--sock=PATH', 'Server socket (overrides hostname and port)') do |path|
            @options.path = path
          end

          opts.on('-dDB', '--db=DB', 'Specify database') do |db|
            @options.db = db
          end

          opts.on('-PPASSWORD', '--password=PASSWORD', 'Specify password') do |password|
            @options.password = password
          end

          opts.on('', '--timeout=TIMEOUT', 'Timeout in seconds (default: 5.0)') do |timeout|
            @options.timeout = timeout.to_i
          end

          opts.on('', '--connect-timeout=TIMEOUT', 'Timeout for initial connect in seconds (default: same as timeout)') do |timeout|
            @options.connect_timeout = timeout.to_i
          end

          opts.on('', '--replica', 'Whether to use readonly replica nodes in Redis Cluster or not') do
            @options.replica = true
          end

          opts.on('', '--cluster=CLUSTER_URL', 'List of cluster nodes to contact, format: URL1,URL2,URL3...') do |cluster|
            @options.cluster = cluster.split(',')
          end

          opts.on('-HSSH_HOST', '--ssh-host=SSH_HOST', 'Specify SSH host') do |ssh_host|
            @options.ssh_host = ssh_host
          end

          opts.on('-OSSH_PORT', '--ssh-port=SSH_PORT', 'Specify SSH port') do |ssh_port|
            @options.ssh_port = ssh_port.to_i
          end

          opts.on('-USSH_USER', '--ssh-user=SSH_USER', 'Specify SSH user') do |ssh_user|
            @options.ssh_user = ssh_user
          end

          opts.on('-WSSH_PASSWORD', '--ssh-password=SSH_PASSWORD', 'Specify SSH password') do |ssh_password|
            @options.ssh_password = ssh_password
          end

          opts.on('-LSSH_LOCAL_PORT', '--ssh-local-port=SSH_LOCAL_PORT', 'Specify local SSH proxy port') do |local_port|
            @options.ssh_local_port = local_port.to_i
          end

          opts.on('-ECODE', '--eval=CODE', 'evaluate CODE') do |code|
            @options.code = code
          end

          opts.on('-V', '--version', 'Prints version') do
            puts "PRIZE #{Prize::VERSION}"
            exit
          end

          opts.on('', '--help', 'Prints this help') do
            puts opts
            exit
          end

        end.parse!

        @options.args = ARGV
      end
    end
  end
end
