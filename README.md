# Prize

Simple Redis CLI client with pry loaded

## Installation


Install it yourself as:

    $ gem install prize

Or:

    $ sudo gem install prize

## Usage

```
Commands:
  prize                 # Simple Redis CLI client with Pry loaded
  prize help [COMMAND]  # Describe available commands or one specific command

Options:
  -u, [--url=URL]                      # Server URL, for a TCP connection: `redis://:[password]@[hostname]:[port]/[db]` (password, port and database are optional), for a unix socket connection: `unix://[path to Redis socket]`. This overrides all other options.
  -h, [--host=HOST]                    # Server hostname (default: 127.0.0.1)
  -p, [--port=N]                       # Server port (default: 6379)
  -s, --socket, [--path=PATH]          # Server socket (overrides hostname and port)
          [--timeout=N]                # Timeout in seconds (default: 5.0)
          [--connect-timeout=N]        # Timeout for initial connect in seconds (default: same as timeout)
  -a, [--password=PASSWORD]            # Password to authenticate against server
  -n, [--db=N]                         # Database number (default: 0)
          [--replica], [--no-replica]  # Whether to use readonly replica nodes in Redis Cluster or not
          [--cluster=CLUSTER]          # List of cluster nodes to contact, format: URL1,URL2,URL3...
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lululau/prize. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the prize project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lululau/prize/blob/master/CODE_OF_CONDUCT.md).
