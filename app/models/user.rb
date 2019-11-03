# frozen_string_literal: true

class User < ApplicationRecord
  # validate :email_verify

  private

  def email_verify
    errors.add(:email, 'Your email has not been verified') unless email_verified
  end
end
