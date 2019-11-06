class RemoveShopifyEmailFromCustomers < ActiveRecord::Migration[6.0]
  def change

    remove_column :customers, :shopify_store_email, :string
  end
end
