class AddShopifyIdToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :shopify_id, :integer
  end
end
