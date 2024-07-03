module Visible
  extend ActiveSupport::Concern

  VALID_PAY_METHOD = ['cash on delivery', 'debit card', 'credit card', 'PhonePe/Paytm/GooglePay']

  included do
    validates :pay_method, inclusion: { in: VALID_PAY_METHOD }
  end
end