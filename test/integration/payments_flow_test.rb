require 'test_helper'

class PaymentsFlowTest < ActionDispatch::IntegrationTest
  include CapybaraHelper
  
  setup do
    sign_in(:customer)
    visit store_product_path(products(:one))
    click_on 'Add to cart'
    visit store_cart_path
    click_on 'Checkout'
  end

  # test "require user" do
  #   assert_equal current_path, new_user_session_path
  # end

  test "checkout" do
    page.save_screenshot('tmp/screenshots/before.png')
    binding.pry
    fill_in 'cc_number', with: ENV['MARKIN_PAYPAL_TEST_CARD_NUMBER']
    fill_in 'expdate_month', with: ENV['MARKIN_PAYPAL_TEST_CARD_EXP_MONTH']
    fill_in 'expdate_year', with: ENV['MARKIN_PAYPAL_TEST_CARD_EXP_YEAR']
    fill_in 'cvv2_number', with: ENV['MARKIN_PAYPAL_TEST_CARD_SECRET']
    fill_in 'last_name', with: ENV['MARKIN_PAYPAL_TEST_CARD_SURNAME']
    fill_in 'first_name', with: ENV['MARKIN_PAYPAL_TEST_CARD_GIVEN_NAME']
    fill_in 'address1', with: ENV['MARKIN_PAYPAL_TEST_CARD_ADDRESS_LINE']
    fill_in 'H_PhoneNumber', with: ENV['MARKIN_PAYPAL_TEST_CARD_PHONE_NUMBER']
    page.save_screenshot('tmp/screenshots/before.png')
    click_on 'submitBilling'
    sleep(5)
    page.save_screenshot('tmp/screenshots/after.png')
  end
end
