class AddShopifyStoreEmailToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :shopify_store_email, :string
  end
end
