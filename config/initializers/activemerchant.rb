ActiveMerchant::Billing::Base.mode = :test
paypal_options = {
  login: ENV['MARKIN_PAYPAL_API_LOGIN'],
  password: ENV['MARKIN_PAYPAL_API_PASSWORD'],
  signature: ENV['MARKIN_PAYPAL_API_SIGNATURE']
}
::PAYMENT_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
