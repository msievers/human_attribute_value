# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "human_attribute_value/version"

Gem::Specification.new do |spec|
  spec.name          = "human_attribute_value"
  spec.version       = HumanAttributeValue::VERSION
  spec.authors       = ["Michael Sievers"]
  spec.email         = ["msievers@users.noreply.github.com"]

  spec.summary       = %q{Translate rails models attribute values just like attribute names.}
  spec.homepage      = "https://github.com/nerdgeschoss/human_attribute_value"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel"
  spec.add_dependency "activesupport"
end
