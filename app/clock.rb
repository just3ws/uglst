require_relative '../config/boot'
require_relative '../config/environment'

include Clockwork

every(1.day, 'hello', at: '00:00') do
  puts "Hello at #{Time.now}"
end
