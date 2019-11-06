class AddShopifyStoreIdToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :shopify_store_id, :integer
  end
end
