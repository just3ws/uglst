# frozen_string_literal: true
uri = URI.parse(ENV['REDIS_URL'])
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)
