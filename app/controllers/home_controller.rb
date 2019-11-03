# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @webhooks = ShopifyAPI::Webhook.find(:all)
    # @order = ShopifyAPI::Order.create(line_items: [{ quantity: 1, variant_id: 31_088_952_541_283 }], financial_status: 'authorized', email: 'foo@example.com')
  end
end
