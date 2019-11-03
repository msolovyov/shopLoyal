class AddEmailVerifiedToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email_verified, :boolean
  end
end
