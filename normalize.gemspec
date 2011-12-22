# encoding: utf-8

Gem::Specification.new do |s|
  s.name           = 'normalize'
  s.version        = '0.0.1'
  s.platform       = Gem::Platform::RUBY
  s.authors        = ['Tom-Eric Gerritsen']
  s.email          = 'tomeric@eet.nu'
  s.homepage       = 'https://github.com/eet-nu/normalize'
  s.summary        = 'The attribute normalizer.'
  s.description    = 'The attribute normalizer.'
  s.files          = `git ls-files`.split("\n")
  s.test_files     = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables    = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths  = ['lib']
  s.add_dependency 'activerecord', '~> 3.0'
end
