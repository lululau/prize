require_relative 'lib/prize/version'

Gem::Specification.new do |spec|
  spec.name          = "prize"
  spec.version       = Prize::VERSION
  spec.authors       = ["Liu Xiang"]
  spec.email         = ["liuxiang921@gmail.com"]

  spec.summary       = %{Simple Redis CLI client with pry loaded}
  spec.description   = %{Simple Redis CLI client with pry loaded}
  spec.homepage      = "https://github.com/lululau/prize"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '~> 6.0.3'
  spec.add_dependency 'net-ssh-gateway', '~> 2.0.0'
  spec.add_dependency 'pry', '~> 0.14.2'
  spec.add_dependency 'rainbow', '~> 3.0.0'
  spec.add_dependency 'redis', '~> 4.0.0'
  spec.add_dependency 'hiredis', '~> 0.6.0'
  spec.add_dependency 'thor', '~> 0.20.0'
end
