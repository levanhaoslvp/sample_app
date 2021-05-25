# frozen_string_literal: true

class DeviseCreateProviders < ActiveRecord::Migration[6.1]
  def change
    create_table :providers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider
      t.string :avatar
    end
  end
end
