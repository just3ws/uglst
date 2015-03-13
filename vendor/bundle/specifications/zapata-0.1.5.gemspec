# -*- encoding: utf-8 -*-
# stub: zapata 0.1.5 ruby lib

Gem::Specification.new do |s|
  s.name = "zapata"
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Domas Bitvinskas"]
  s.date = "2014-12-05"
  s.description = "Who has time to write tests? This is a revolutional tool to make them write themselves."
  s.email = ["domas.bitvinskas@me.com"]
  s.executables = ["zapata"]
  s.files = ["bin/zapata"]
  s.homepage = "https://github.com/Nedomas/zapata"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new("~> 2.0")
  s.rubygems_version = "2.4.5"
  s.summary = "Automatic automated test writer"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<parser>, ["= 2.2.0.pre.8"])
      s.add_runtime_dependency(%q<unparser>, ["~> 0.1"])
      s.add_runtime_dependency(%q<andand>, ["~> 1.3"])
      s.add_runtime_dependency(%q<rails>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<slop>, ["~> 3.4"])
      s.add_runtime_dependency(%q<rspec-rails>, [">= 0"])
      s.add_runtime_dependency(%q<require_all>, ["~> 1.3"])
      s.add_runtime_dependency(%q<file-temp>, ["~> 1.2"])
      s.add_runtime_dependency(%q<rspec>, [">= 0"])
      s.add_runtime_dependency(%q<memoist>, [">= 0"])
      s.add_development_dependency(%q<pry>, ["~> 0.9"])
      s.add_development_dependency(%q<pry-stack_explorer>, ["~> 0.4"])
      s.add_development_dependency(%q<bundler>, ["~> 1.6"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
    else
      s.add_dependency(%q<parser>, ["= 2.2.0.pre.8"])
      s.add_dependency(%q<unparser>, ["~> 0.1"])
      s.add_dependency(%q<andand>, ["~> 1.3"])
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<slop>, ["~> 3.4"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<require_all>, ["~> 1.3"])
      s.add_dependency(%q<file-temp>, ["~> 1.2"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<memoist>, [">= 0"])
      s.add_dependency(%q<pry>, ["~> 0.9"])
      s.add_dependency(%q<pry-stack_explorer>, ["~> 0.4"])
      s.add_dependency(%q<bundler>, ["~> 1.6"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<parser>, ["= 2.2.0.pre.8"])
    s.add_dependency(%q<unparser>, ["~> 0.1"])
    s.add_dependency(%q<andand>, ["~> 1.3"])
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<slop>, ["~> 3.4"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<require_all>, ["~> 1.3"])
    s.add_dependency(%q<file-temp>, ["~> 1.2"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<memoist>, [">= 0"])
    s.add_dependency(%q<pry>, ["~> 0.9"])
    s.add_dependency(%q<pry-stack_explorer>, ["~> 0.4"])
    s.add_dependency(%q<bundler>, ["~> 1.6"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
  end
end
