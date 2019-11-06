# frozen_string_literal: true

class AddShopifyIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :shopify_id, :integer
    add_index :users, :shopify_id, unique: true
  end
end
