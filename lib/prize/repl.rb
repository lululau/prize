require 'pry'
require 'prize/commands'
require 'rainbow'

module Prize
  class Repl
    def initialize
      @redis = App.redis
      Pry.config.prompt = Pry::Prompt.new("", "", prompt)
      Pry.start(@redis)
    end

    def prompt
      opts = @redis.instance_variable_get('@client').options
      if App.options.ssh_host
        host = "#{App.options.ssh_host}:#{App.options.host || '127.0.0.1'}:#{App.options.port || 6379}/#{opts[:db]}"
      else
        host = opts[:url] || opts[:path] || "#{opts[:host]}:#{opts[:port]}/#{opts[:db]}"
      end
      [proc do |obj, nest_level, _|
         if obj == @redis && nest_level == 0
           nest_level_prompt = ''
         else
           nest_level_prompt = "(#{obj}:#{nest_level})"
         end
         "%s#{Rainbow('@').green}%s#{nest_level_prompt} %s " % [Rainbow('PRIZE').red, Rainbow(host).yellow, Rainbow('❯').green]
       end]
    end
  end
end
