# Use heartbeat for system-up related pings.
class HeartbeatController < ApplicationController
  def ping
    render text: File.open(Rails.root.join('heartbeat.txt')) { |f| f.gets(nil) }
  rescue Errno::ENOENT
    render text: 'Not found', status: :not_found
  end
end
