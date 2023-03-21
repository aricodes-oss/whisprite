# frozen_string_literal: true

require "dotenv/load"
require "yaml"
require "active_record"

# Load and initialize ActiveRecord
project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob("#{project_root}/app/models/*.rb").sort.each { |f| require f }

connection_details = YAML.safe_load(File.open("config/database.yml"))
ActiveRecord::Base.establish_connection(connection_details)

module Whisprite
  class Error < StandardError; end
end

# Load sub modules
require "require_all"
require_all "#{File.dirname(__FILE__)}/whisprite"
