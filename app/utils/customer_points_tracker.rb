# frozen_string_literal: true

class CustomerPointsTracker
  def initialize(customer_data, shop_id)
    @customer = Customer.where(
      'email = ? AND shopify_store_id = ?',
      customer_data['email'], shop_id
    ).take
    @customer ||= Customer.create(
      shopify_id: customer_data['id'],
      email: customer_data['email'],
      points: 0,
      first_name: customer_data['first_name'],
      last_name: customer_data['last_name'],
      shopify_store_id: shop_id
    )
  end

  # main method that turns money into points and
  # emails the customer
  def process_points(money_spent)
    new_points = calc_points(money_spent)
    new_total_points = add_points(new_points)
    # send email with points update
    email_points(new_points, new_total_points)
  end

  # Give back points for money spent, no modification
  def calc_points(money_spent)
    multiplier = User.find_by_shopify_id(@customer.shopify_store_id)[:multiplier]
    money_spent.to_d * multiplier.to_d
  end

  def add_points(new_points)
    new_total_points = @customer[:points].to_d + new_points
    @customer.update(points: new_total_points)
    new_total_points
  end

  def email_points(new_points, new_total_points)
    LoyaltyMailer.points_update(
      @customer.email,
      new_points,
      new_total_points
    ).deliver_now
  end
end
