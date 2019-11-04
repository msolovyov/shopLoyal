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

  # Give back points for money spent, no modification
  def calc_points(money_spent)
    multiplier = User.find_by_email(@customer.shopify_store_email)[:multiplier]
    money_spent.to_d * multiplier.to_d
  end

  def add_points(money_spent)
    new_points = calc_points(money_spent)
    new_total_points = @customer[:points].to_d + new_points
    @customer.update(points: new_total_points)
    new_total_points
  end

  def points_email(new_points, new_total_points)
    LoyaltyMailer.points_update(@customer.shopify_store_email,
                                @customer.email,
                                new_points,
                                new_total_points).deliver_now
  end
end
