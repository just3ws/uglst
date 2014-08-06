rails_env = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'

threads 4, 4

bind "unix:///var/ugtastic/uglst/shared/tmp/puma/uglst-puma.sock"
pidfile "/var/ugtastic/uglst/current/tmp/puma/pid"
state_path "/var/ugtastic/uglst/current/tmp/puma/state"

activate_control_app
