class RemoveEmailVerifiedFromUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :email_verified, :boolean
  end
end
