if Rails.env.production?
  ActiveMerchant::Billing::Base.mode = :production
else
  ActiveMerchant::Billing::Base.mode = :test
end

paypal_options = {
  login: ENV['MARKIN_PAYPAL_API_LOGIN'],
  password: ENV['MARKIN_PAYPAL_API_PASSWORD'],
  signature: ENV['MARKIN_PAYPAL_API_SIGNATURE']
}
::PAYMENT_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
