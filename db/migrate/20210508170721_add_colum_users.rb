# frozen_string_literal: true

class AddColumUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :provider, :string, default: false
  end
end
