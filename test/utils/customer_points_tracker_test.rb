# frozen_string_literal: true

require 'test_helper'
class CustomerPointsTrackerTest < ActiveSupport::TestCase
  def setup
    @shop_email = 'test5@shop.ca'
    @customer_data = {
      'id' => 2_690_461_597_799, 'email' => 'blah@blah.com', 'accepts_marketing' => false, 'created_at' => '2019-11-03T16:31:27-05:00', 'updated_at' => '2019-11-03T20:02:21-05:00', 'first_name' => 'dawn', 'last_name' => 'misty', 'orders_count' => 1, 'state' => 'disabled', 'total_spent' => '2.00', 'last_order_id' => 1_852_653_076_583, 'note' => nil, 'verified_email' => true, 'multipass_identifier' => nil, 'tax_exempt' => false, 'phone' => nil, 'tags' => '', 'last_order_name' => '#1002', 'currency' => 'CAD', 'accepts_marketing_updated_at' => '2019-11-03T19:07:27-05:00', 'marketing_opt_in_level' => nil, 'admin_graphql_api_id' => 'gid://shopify/Customer/2690461597799'
    }
  end

  test 'creates customer' do
    tracker = CustomerPointsTracker.new(@customer_data, @shop_email)
    assert tracker
    cust = Customer.find_by_email('blah@blah.com')
    assert cust
  end

  test 'points multiplication' do
    tracker = CustomerPointsTracker.new(@customer_data, 'test5@shop.ca')
    u1 = User.find_by_email('test5@shop.ca')
    assert u1
    assert_equal(5, u1.multiplier)
    new_p = tracker.calc_points(2)
    assert_equal(10, new_p)
    tracker.add_points(new_p)
    cust = Customer.find_by_email('blah@blah.com')
    assert_equal(10, cust.points)
  end
end
