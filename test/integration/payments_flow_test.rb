require 'test_helper'

class PaymentsFlowTest < ActionDispatch::IntegrationTest
  include CapybaraHelper
  
  # setup do
  #   sign_in(:customer)
  #   visit store_product_path(products(:one))
  #   click_on 'Add to cart'
  #   visit store_order_path
  #   click_on 'Checkout'
  # end

  # teardown do
  #   sign_out
  # end

  # test "require user" do
  #   checkout(products(:one))
  #   assert_equal current_path, new_user_session_path
  # end

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

  # test "checkout" do
  #   binding.pry
  #   fill_in 'cc_number', with: ENV['MARKIN_PAYPAL_TEST_CARD_NUMBER']
  #   fill_in 'expdate_month', with: ENV['MARKIN_PAYPAL_TEST_CARD_EXP_MONTH']
  #   fill_in 'expdate_year', with: ENV['MARKIN_PAYPAL_TEST_CARD_EXP_YEAR']
  #   fill_in 'cvv2_number', with: ENV['MARKIN_PAYPAL_TEST_CARD_SECRET']
  #   fill_in 'address1', with: ENV['MARKIN_PAYPAL_TEST_CARD_ADDRESS_LINE']
  #   fill_in 'H_PhoneNumber', with: ENV['MARKIN_PAYPAL_TEST_CARD_PHONE_NUMBER']
  #   page.save_screenshot('tmp/screenshots/before.png')
  #   click_on 'submitBilling'
  #   sleep(5)
  # end
end
