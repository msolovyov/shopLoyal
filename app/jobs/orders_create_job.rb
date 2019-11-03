# frozen_string_literal: true

class OrdersCreateJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)
    shop.with_shopify_session do
      # https://help.shopify.com/en/api/reference/events/webhook#index-2019-10
      # create or update customer table with new points
      p '--------------------------------------------------'
      p webhook
      p shop
      if webhook[:customer]
        customer = Customer.find_by_email(webhook[:customer][:email])
      else
        Customer.find_by_email(webhook[:email])
      end
      customer ||= Customer.create(
        email: webhook[:customer][:email],
        points: 0,
        firstName: webhook[:customer][:first_name],
        lastName: webhook[:customer][:last]
      )
      spent = webhook[:total_price]
      shop_email = ShopifyAPI::Shop.current.email
      multiplier = User.find_by_email(shop_email)[:multiplier]
      new_points = spent.to_d * multiplier.to_d
      new_total_points = customer[:points].to_d + new_points
      customer.update(points: new_total_points)
      # send email with points update
    end
  end
end
