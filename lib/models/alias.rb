# frozen_string_literal: true

require "active_record"

class Alias < ActiveRecord::Base
  def self.for(name)
    where target: name.to_s
  end
end
