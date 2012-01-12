# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fifthcard/version"

Gem::Specification.new do |s|
  s.name        = "fifthcard"
  s.version     = Fifthcard::VERSION
  s.authors     = ["Kristján Pétursson"]
  s.email       = ["kristjan@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{An algorithmic magic trick}
  s.description = %q{Based on the PayPal card puzzle described at http://www.quora.com/What-s-the-hardest-puzzle-question-asked-at-PayPal}

  s.rubyforge_project = "fifthcard"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('deck', '>=1.1.2')
end
