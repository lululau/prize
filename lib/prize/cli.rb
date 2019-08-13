require 'thor'
require 'redis'
require 'hiredis'
require 'pry'

module Prize
  class Cli < ::Thor

    default_command :main

    desc '', 'Simple Redis CLI client with Pry loaded'
    class_option :url, type: :string, aliases: ['-u'], required: false, desc: 'Server URL, for a TCP connection: `redis://:[password]@[hostname]:[port]/[db]` (password, port and database are optional), for a unix socket connection: `unix://[path to Redis socket]`. This overrides all other options.'
    class_option :host, type: :string, aliases: ['-h'], required: false, desc: 'Server hostname (default: 127.0.0.1)'
    class_option :port, type: :numeric, aliases: ['-p'], required: false, desc: 'Server port (default: 6379)'
    class_option :path, type: :string, aliases: ['-s', '--socket'], required: false, desc: 'Server socket (overrides hostname and port)'
    class_option :timeout, type: :numeric, required: false, desc: 'Timeout in seconds (default: 5.0)'
    class_option :connect_timeout, type: :numeric, required: false, desc: 'Timeout for initial connect in seconds (default: same as timeout)'
    class_option :password, type: :string, aliases: ['-a'], required: false, desc: 'Password to authenticate against server'
    class_option :db, type: :numeric, aliases: ['-n'], required: false, desc: 'Database number (default: 0)'
    class_option :replica, type: :boolean, required: false, desc: 'Whether to use readonly replica nodes in Redis Cluster or not'
    class_option :cluster, type: :string, required: false, desc: 'List of cluster nodes to contact, format: URL1,URL2,URL3...'
    def main
      redis = Redis.new(build_options)
      Pry.config.prompt = build_prompt(redis)
      Pry.start(redis)
    end

    no_commands do
      def build_options
        opts = options.to_h.merge(driver: :hiredis)
        opts['cluster'] = opts['cluster'].split(',') if opts['cluster']
        opts
      end

      def build_prompt(redis)
        opts = redis.instance_variable_get('@client').options
        host = opts[:url] || opts[:path] || "#{opts[:host]}:#{opts[:port]}/#{opts[:db]}"
        prompt_fn = proc do |obj, nest_level, _|
          p = ""
          p += if obj == redis
                "Redis<#{host}>:"
              else
                "#{obj}:"
              end
          p += "#{nest_level}> "
        end

        [prompt_fn,
        proc do |obj, nest_level, other|
          "*#{prompt_fn.call obj, nest_level, other}"
        end
        ]
      end
    end
  end
end
