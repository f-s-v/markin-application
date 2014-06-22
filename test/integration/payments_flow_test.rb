require 'test_helper'

class PaymentsFlowTest < ActionDispatch::IntegrationTest
  include CapybaraHelper

  test "require user" do
    sign_out
    add_to_cart(products(:one))
    visit new_store_order_shipping_info_path
    fill_order_shipping_info(orders(:us_customer).shipping_info)
    find('[name=commit]').click
    visit new_store_order_payment_path
    assert_equal current_path, new_user_session_path
  end

  test "checkout with valid card" do
    checkout(users(:customer), orders(:us_customer), products(:one))
    fill_in 'cc_number', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_NUMBER']
    fill_in 'expdate_month', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_EXP_MONTH']
    fill_in 'expdate_year', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_EXP_YEAR']
    fill_in 'cvv2_number', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_SECRET']
    if all('#H_PhoneNumberUS').present?
      fill_in 'H_PhoneNumberUS', with: orders(:us_customer).shipping_info.phone_number
    end
    fill_in 'cvv2_number', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_SECRET']
    click_on 'submitBilling'
    sleep(5)
    sign_in(users(:customer))
    assert_equal Order::Payment.last.state, 'paid'
  end

  test "payment error" do
    checkout(users(:customer), orders(:us_customer), products(:payment_error))
    fill_in 'cc_number', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_NUMBER']
    fill_in 'expdate_month', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_EXP_MONTH']
    fill_in 'expdate_year', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_EXP_YEAR']
    fill_in 'cvv2_number', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_SECRET']
    if all('#H_PhoneNumberUS').present?
      fill_in 'H_PhoneNumberUS', with: orders(:us_customer).shipping_info.phone_number
    end
    click_on 'submitBilling'
    sleep(5)
    sign_in(users(:customer))
    assert_equal Order::Payment.last.state, 'failed'
  end
end
