require 'net/ssh/gateway'
require 'redis'

module Prize
  class App

    class << self
      attr_accessor :options, :redis, :redis_client
    end

    def initialize(options)
      require 'active_support/all'
      @options = options
      load_initializer!
      @redis = Redis.new(connect_options)
      App.options = @options
      App.redis = @redis
      App.redis_client = @redis.instance_variable_get('@client')
    end

    def connect_options
      opts = @options.to_h.slice(:url, :host, :port, :path, :db, :password, :timeout,
                                   :connect_timeout, :replica, :cluster)
      if @options.ssh_host
        proxy = start_ssh_proxy!
        opts.merge!(proxy)
      end
      opts
    end

    def load_initializer!
      if File.exists?(File.expand_path('~/.prizerc'))
        load(File.expand_path('~/.prizerc'))
      end
    end

    def start_ssh_proxy!
      ssh_config = {
        host: @options.ssh_host,
        forward_host: @options.host || '127.0.0.1',
        forward_port: @options.port || 6379
      }
      @options.ssh_user.try { |e| ssh_config.merge!(user: e) }
      @options.ssh_port.try { |e| ssh_config.merge!(port: e) }
      @options.ssh_password.try { |e| ssh_config.merge!(password: e) }
      @options.ssh_local_port.try { |e| ssh_config.merge!(local_port: e) }
      local_ssh_proxy_port = Prize::SSHProxy.connect(ssh_config)
      {
        host: '127.0.0.1',
        port: local_ssh_proxy_port
      }
    end

    def run!
      if @options.code.present?
        @redis.instance_eval(@options.code)
      elsif @options.args.present?
        @options.args.each do |rb|
          @redis.instance_eval(IO.read(rb))
        end
      elsif STDIN.isatty
        run_repl!
      else
        @redis.instance_eval(STDIN.read)
      end
    end

    def run_repl!
      Repl.new
    end
  end
end
