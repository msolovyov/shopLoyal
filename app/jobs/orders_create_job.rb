# frozen_string_literal: true

class OrdersCreateJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)
    shop.with_shopify_session do
      # https://help.shopify.com/en/api/reference/events/webhook#index-2019-10
      # create or update customer table with new points
      p '--------------------------------------------------'
      p webhook

      # Get customer from param
      tracker = CustomerPointsTracker.new(webhook['customer'])
      # figure out points
      tracker.add_points(webhook['total_price'], ShopifyAPI::Shop.current.email)
      # send email with points update
    end
  end
end
