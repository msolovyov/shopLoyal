# frozen_string_literal: true

class OrdersCreateJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)
    shop.with_shopify_session do
      # https://help.shopify.com/en/api/reference/events/webhook#index-2019-10
      # create or update customer table with new points

      tracker = CustomerPointsTracker.new(webhook['customer'], ShopifyAPI::Shop.current.id)
      tracker.process_points(webhook['total_price'])
    end
  end
end
