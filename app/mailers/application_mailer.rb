# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  def account_activation
    @greeting = 'Hi'
    mail to: 'to@example.org'
  end

  def password_reset
    @greeting = 'Hi'
    mail to: 'to@example.org'
  end
end
