# frozen_string_literal: true

require_relative "lib/usual_suspect/version"

Gem::Specification.new do |spec|
  spec.name          = "usual_suspect"
  spec.version       = "1.0.0"
  spec.authors       = ["DeadKennedyx"]
  spec.email         = ["juan.dw.ft@gmail.com"]

  spec.summary       = "Gem that tracks suspicious activity within your user model."
  spec.homepage      = "https://github.com/DeadKennedyx/UsualSuspect"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/DeadKennedyx/UsualSuspect"
  spec.metadata["changelog_uri"] = "https://github.com/DeadKennedyx/UsualSuspect/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
    Dir[File.join(File.dirname(__FILE__), 'tasks/**/*.rake')].each { |f| load f }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "geocoder", "~> 1.8.2"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
