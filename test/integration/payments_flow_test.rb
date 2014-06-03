require 'test_helper'

class PaymentsFlowTest < ActionDispatch::IntegrationTest
  include CapybaraHelper

  test "require user" do
    add_to_cart(products(:one))
    visit edit_store_order_path
    fill_order(orders(:valid))
    find('[name=commit]').click
    sign_out
    visit new_store_order_payment_path
    assert_equal current_path, new_user_session_path
  end

  test "checkout with valid card" do
    checkout(users(:customer), orders(:valid), products(:one))
    fill_in 'cc_number', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_NUMBER']
    fill_in 'expdate_month', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_EXP_MONTH']
    fill_in 'expdate_year', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_EXP_YEAR']
    fill_in 'cvv2_number', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_SECRET']
    click_on 'submitBilling'
    sleep(5)
    sign_in(users(:customer))
    assert_equal Order::Payment.last.state, 'paid'
  end

  test "payment error" do
    checkout(users(:customer), orders(:valid), products(:payment_error))
    fill_in 'cc_number', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_NUMBER']
    fill_in 'expdate_month', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_EXP_MONTH']
    fill_in 'expdate_year', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_EXP_YEAR']
    fill_in 'cvv2_number', with: ENV['MARKIN_PAYPAL_TEST_US_CARD_SECRET']
    click_on 'submitBilling'
    sleep(5)
    sign_in(users(:customer))
    assert_equal Order::Payment.last.state, 'failed'
  end
end
