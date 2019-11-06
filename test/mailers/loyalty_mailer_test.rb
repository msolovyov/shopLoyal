# frozen_string_literal: true

require 'test_helper'

class LoyaltyMailerTest < ActionMailer::TestCase
  test 'send points update' do
    # Create the email and store it for further assertions
    email = LoyaltyMailer.points_update(
      'customer@example.com',
      10,
      20
    )

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to

    assert_equal ['customer@example.com'], email.to
    assert_equal 'You earned more points!', email.subject
  end
end
