# frozen_string_literal: true

class AddUidUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uid, :string

    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
