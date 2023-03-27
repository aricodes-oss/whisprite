# frozen_string_literal: true

require "twitch/bot"

class Twitch::Bot::EventHandler
  def command_aliases
    Alias.for(id).map(&:name)
  end
end

require_relative "handlers/join"
