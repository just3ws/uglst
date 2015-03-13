# -*- encoding: utf-8 -*-
# stub: fatalistic 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "fatalistic"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Norman Clarke"]
  s.date = "2011-12-21"
  s.description = "Active Record provides \"optimistic\" and \"pessimistic\" modules for row-level\nlocking, but provide nothing to do full-table locking. Fatalistic provides this.\n"
  s.email = ["norman@njclarke.com"]
  s.homepage = "http://github.com/bvision/fatalistic"
  s.rubygems_version = "2.4.5"
  s.summary = "Table-level locking for Active Record"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end
