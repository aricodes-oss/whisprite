# frozen_string_literal: true

class CreateAliasTable < ActiveRecord::Migration[7.0]
  def change
    create_table :aliases do |t|
      t.string :target
      t.string :name
      t.timestamps
    end

    add_index :aliases, :target
  end
end
