# frozen_string_literal: true

class CustomerPointsTracker
  def initialize(customer_data, shop_email)
    @customer = Customer.where(
      'email = ? AND shopify_store_email = ?',
      customer_data['email'], shop_email
    ).take
    @customer ||= Customer.create(
      shopify_id: customer_data['id'],
      email: customer_data['email'],
      points: 0,
      first_name: customer_data['first_name'],
      last_name: customer_data['last_name'],
      shopify_store_email: shop_email
    )
  end

  def add_points(money_spent)
    multiplier = User.find_by_email(@customer.shopify_store_email)[:multiplier]
    new_points = money_spent.to_d * multiplier.to_d
    new_total_points = @customer[:points].to_d + new_points
    @customer.update(points: new_total_points)
  end
end
