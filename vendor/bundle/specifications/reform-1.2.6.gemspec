# -*- encoding: utf-8 -*-
# stub: reform 1.2.6 ruby lib

Gem::Specification.new do |s|
  s.name = "reform"
  s.version = "1.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nick Sutterer", "Garrett Heinlen"]
  s.date = "2015-02-03"
  s.description = "Freeing your AR models from form logic."
  s.email = ["apotonick@gmail.com", "heinleng@gmail.com"]
  s.homepage = "https://github.com/apotonick/reform"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "Decouples your models from form by giving you form objects with validation, presentation, workflows and security."

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<representable>, ["~> 2.1.0"])
      s.add_runtime_dependency(%q<disposable>, ["~> 0.0.5"])
      s.add_runtime_dependency(%q<uber>, ["~> 0.0.11"])
      s.add_runtime_dependency(%q<activemodel>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<minitest>, ["= 5.4.1"])
      s.add_development_dependency(%q<activerecord>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<virtus>, [">= 0"])
      s.add_development_dependency(%q<rails>, [">= 0"])
      s.add_development_dependency(%q<actionpack>, [">= 0"])
    else
      s.add_dependency(%q<representable>, ["~> 2.1.0"])
      s.add_dependency(%q<disposable>, ["~> 0.0.5"])
      s.add_dependency(%q<uber>, ["~> 0.0.11"])
      s.add_dependency(%q<activemodel>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<minitest>, ["= 5.4.1"])
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<virtus>, [">= 0"])
      s.add_dependency(%q<rails>, [">= 0"])
      s.add_dependency(%q<actionpack>, [">= 0"])
    end
  else
    s.add_dependency(%q<representable>, ["~> 2.1.0"])
    s.add_dependency(%q<disposable>, ["~> 0.0.5"])
    s.add_dependency(%q<uber>, ["~> 0.0.11"])
    s.add_dependency(%q<activemodel>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<minitest>, ["= 5.4.1"])
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<virtus>, [">= 0"])
    s.add_dependency(%q<rails>, [">= 0"])
    s.add_dependency(%q<actionpack>, [">= 0"])
  end
end
