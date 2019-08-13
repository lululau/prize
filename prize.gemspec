
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "prize/version"

Gem::Specification.new do |spec|
  spec.name          = "prize"
  spec.version       = Prize::VERSION
  spec.authors       = ["Liu Xiang"]
  spec.email         = ["liuxiang921@gmail.com"]

  spec.summary       = %{Simple Redis CLI client with pry loaded}
  spec.description   = %{Simple Redis CLI client with pry loaded}
  spec.homepage      = "https://github.com/lululau/prize"
  spec.license       = "MIT"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport'
  spec.add_dependency 'redis', '>= 4.0.0'
  spec.add_dependency 'hiredis', '>= 0.6.0'
  spec.add_dependency 'thor', '~> 0.20.0'
  spec.add_dependency 'pry', '>= 0.12.0'

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
