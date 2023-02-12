# frozen_string_literal: true

class CreateViewingParties < ActiveRecord::Migration[5.2]
  def change
    create_table :viewing_parties do |t|
      t.integer :movie_id
      t.date :date
      t.time :start_time
      t.integer :party_duration

      t.timestamps
    end
  end
end
