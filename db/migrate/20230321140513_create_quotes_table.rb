# frozen_string_literal: true

class CreateQuotesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.text :body
      t.string :author_id

      t.timestamps
    end
  end
end
