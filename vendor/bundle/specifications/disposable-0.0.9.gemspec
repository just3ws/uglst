# -*- encoding: utf-8 -*-
# stub: disposable 0.0.9 ruby lib

Gem::Specification.new do |s|
  s.name = "disposable"
  s.version = "0.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nick Sutterer"]
  s.date = "2014-11-06"
  s.description = "Domain-Oriented Refactoring Framework."
  s.email = ["apotonick@gmail.com"]
  s.homepage = ""
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "Domain-Oriented Refactoring Framework."

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<uber>, [">= 0"])
      s.add_runtime_dependency(%q<representable>, ["~> 2.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<minitest>, ["= 5.4.1"])
    else
      s.add_dependency(%q<uber>, [">= 0"])
      s.add_dependency(%q<representable>, ["~> 2.0"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<minitest>, ["= 5.4.1"])
    end
  else
    s.add_dependency(%q<uber>, [">= 0"])
    s.add_dependency(%q<representable>, ["~> 2.0"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<minitest>, ["= 5.4.1"])
  end
end
