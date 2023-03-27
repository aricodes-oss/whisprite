# frozen_string_literal: true

require "dotenv/load"
require "yaml"
require "active_record"
require "twitch/bot"

module Whisprite
  class Error < StandardError; end
end

# Load and initialize ActiveRecord specifically
project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob("#{project_root}/models/*.rb").sort.each { |f| require f }

connection_details = YAML.safe_load(File.open("config/database.yml"))
ActiveRecord::Base.establish_connection(connection_details)

# ...then load sub modules
require "require_all"
require_all "#{File.dirname(__FILE__)}/whisprite"

module Whisprite
  class Bot
    def initialize
      @client = Twitch::Bot::Client.new(
        channel: ENV.fetch("TWITCH_CHANNEL", nil),
        config: configuration
      ) do
        register_handler(Whisprite::JoinHandler)
        # register_handler(Whisprite::SubscriptionHandler)
        # register_handler(Whisprite::PlanCommandHandler)
        # register_handler(Whisprite::StreamerCommandHandler)
        # register_handler(Whisprite::QuoteCommandHandler)
        # register_handler(Whisprite::DefendCommandHandler)
        # register_handler(Whisprite::AttackCommandHandler)
        # register_handler(Whisprite::ShoutoutHandler)
      end
    end

    def run
      client.run
    end

    private

    attr_reader :client

    def adapter_class
      if development_mode?
        # "Twitch::Bot::Adapter::Terminal"
      end
      "Twitch::Bot::Adapter::Irc"
    end

    def memory_class
      if development_mode?
        "Twitch::Bot::Memory::Hash"
      else
        "Twitch::Bot::Memory::Redis"
      end
    end

    def configuration
      Twitch::Bot::Config.new(
        settings: {
          botname: ENV.fetch("TWITCH_USERNAME", nil),
          irc: {
            nickname: ENV.fetch("TWITCH_USERNAME", nil),
            password: ENV.fetch("TWITCH_PASSWORD", nil)
          },
          adapter: adapter_class,
          memory: "Twitch::Bot::Memory::Redis",
          log: {
            file: logfile,
            level: loglevel
          }
        }
      )
    end

    def logfile
      if ENV["BOT_LOGFILE"]
        File.new(ENV["BOT_LOGFILE"], "w")
      else
        $stdout
      end
    end

    def loglevel
      (ENV["BOT_LOGLEVEL"] || "info").to_sym
    end

    def development_mode?
      ENV["BOT_MODE"] == "development"
    end
  end
end
