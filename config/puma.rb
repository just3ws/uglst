workers Integer(ENV['PUMA_WORKERS'] || 3)
threads Integer(ENV['MIN_THREADS'] || 1), Integer(ENV['MAX_THREADS'] || 16)

rackup DefaultRackup
port ENV['PORT'] || '4321'
environment ENV['RACK_ENV'] || 'development'
