# frozen_string_literal: true

require "twitch/bot"
require_relative "../../models/alias"

class Twitch::Bot::EventHandler
  def command_aliases
    Alias.for(id).map(&:name)
  end
end

module Whisprite
  class JoinHandler < Twitch::Bot::EventHandler
    def call
      client.send_message "Systems initialized."
    end

    def self.handled_events
      [:join]
    end

    def id
      :join
    end
  end
end
