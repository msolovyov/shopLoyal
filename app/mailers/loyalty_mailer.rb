# frozen_string_literal: true

class LoyaltyMailer < ApplicationMailer
  def points_update(from, to, new_points, total_points)
    @new_points = new_points
    @new_total_points = total_points
    mail(to: to, from: from, subject: 'You earned more points!')
  end
end
