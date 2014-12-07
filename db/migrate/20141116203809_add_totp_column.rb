class AddTotpColumn < ActiveRecord::Migration
  def change
    add_column :users, :totp_token, :string
  end
end
