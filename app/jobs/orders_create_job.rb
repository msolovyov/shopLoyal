# frozen_string_literal: true

class OrdersCreateJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)
    shop.with_shopify_session do
      # https://help.shopify.com/en/api/reference/events/webhook#index-2019-10
      # create or update customer table with new points
      p '--------------------------------------------------'
      # p webhook
      p shop

      # Get customer from param
      tracker = CustomerPointsTracker.new(webhook['customer'], ShopifyAPI::Shop.current.email)
      # figure out points
      tracker.add_points(webhook['total_price'])
      # send email with points update
    end
  end
end
