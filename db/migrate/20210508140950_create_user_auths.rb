# frozen_string_literal: true

class CreateUserAuths < ActiveRecord::Migration[6.1]
  def change
    create_table :user_auths do |t|
      t.string :name
      t.string :uid
      t.string :provider

      t.timestamps
    end
  end
end
