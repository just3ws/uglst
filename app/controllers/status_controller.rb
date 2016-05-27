# frozen_string_literal: true
# Status of the service. OK is okay.
class StatusController < ApplicationController
  def ping
    render text: 'OK'
  end
end
