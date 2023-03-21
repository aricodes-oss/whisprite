# frozen_string_literal: true

require "twitchrb"

module Whisprite::Twitch
  def self.api
    return @api_client unless @api_client.nil?

    @api_client = Twitch::Client.new(
      client_id: ENV.fetch("TWITCH_CLIENT_ID"),
      access_token: ENV.fetch("TWITCH_ACCESS_TOKEN")
    )
  end
end
