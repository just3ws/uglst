# -*- encoding: utf-8 -*-
# stub: rollbar 1.4.4 ruby lib

Gem::Specification.new do |s|
  s.name = "rollbar"
  s.version = "1.4.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Rollbar, Inc."]
  s.date = "2015-02-06"
  s.description = "Rails plugin to catch and send exceptions to Rollbar"
  s.email = ["support@rollbar.com"]
  s.homepage = "https://github.com/rollbar/rollbar-gem"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "Reports exceptions to Rollbar"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.3"])
      s.add_development_dependency(%q<rails>, [">= 3.0.0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 2.14.0"])
      s.add_development_dependency(%q<database_cleaner>, ["~> 1.0.0"])
      s.add_development_dependency(%q<girl_friday>, [">= 0.11.1"])
      s.add_development_dependency(%q<sucker_punch>, [">= 1.0.0"])
      s.add_development_dependency(%q<sidekiq>, [">= 2.13.0"])
      s.add_development_dependency(%q<genspec>, [">= 0.2.8"])
      s.add_development_dependency(%q<sinatra>, [">= 0"])
      s.add_development_dependency(%q<resque>, [">= 0"])
      s.add_development_dependency(%q<delayed_job>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0.9.0"])
    else
      s.add_dependency(%q<multi_json>, ["~> 1.3"])
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<rspec-rails>, [">= 2.14.0"])
      s.add_dependency(%q<database_cleaner>, ["~> 1.0.0"])
      s.add_dependency(%q<girl_friday>, [">= 0.11.1"])
      s.add_dependency(%q<sucker_punch>, [">= 1.0.0"])
      s.add_dependency(%q<sidekiq>, [">= 2.13.0"])
      s.add_dependency(%q<genspec>, [">= 0.2.8"])
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<resque>, [">= 0"])
      s.add_dependency(%q<delayed_job>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0.9.0"])
    end
  else
    s.add_dependency(%q<multi_json>, ["~> 1.3"])
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<rspec-rails>, [">= 2.14.0"])
    s.add_dependency(%q<database_cleaner>, ["~> 1.0.0"])
    s.add_dependency(%q<girl_friday>, [">= 0.11.1"])
    s.add_dependency(%q<sucker_punch>, [">= 1.0.0"])
    s.add_dependency(%q<sidekiq>, [">= 2.13.0"])
    s.add_dependency(%q<genspec>, [">= 0.2.8"])
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<resque>, [">= 0"])
    s.add_dependency(%q<delayed_job>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0.9.0"])
  end
end
