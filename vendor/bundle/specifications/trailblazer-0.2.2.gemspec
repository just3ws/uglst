# -*- encoding: utf-8 -*-
# stub: trailblazer 0.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "trailblazer"
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nick Sutterer"]
  s.date = "2015-01-22"
  s.description = "A high-level, modular architecture for Rails with domain and form objects, view models, twin decorators and representers."
  s.email = ["apotonick@gmail.com"]
  s.homepage = "http://www.trailblazerb.org"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "A new architecture for Rails."

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<uber>, [">= 0.0.10"])
      s.add_runtime_dependency(%q<representable>, ["< 2.2.0", ">= 2.1.1"])
      s.add_runtime_dependency(%q<reform>, ["~> 1.2.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<sidekiq>, ["~> 3.1.0"])
      s.add_development_dependency(%q<rails>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<actionpack>, [">= 3.0.0"])
      s.add_dependency(%q<uber>, [">= 0.0.10"])
      s.add_dependency(%q<representable>, ["< 2.2.0", ">= 2.1.1"])
      s.add_dependency(%q<reform>, ["~> 1.2.0"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<sidekiq>, ["~> 3.1.0"])
      s.add_dependency(%q<rails>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 3.0.0"])
    s.add_dependency(%q<uber>, [">= 0.0.10"])
    s.add_dependency(%q<representable>, ["< 2.2.0", ">= 2.1.1"])
    s.add_dependency(%q<reform>, ["~> 1.2.0"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<sidekiq>, ["~> 3.1.0"])
    s.add_dependency(%q<rails>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
  end
end
