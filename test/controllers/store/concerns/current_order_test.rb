require 'test_helper'

class Store::Concerns::CurrentOrderTest < ActionController::TestCase

  class TestController < ApplicationController
    include Store::Concerns::CurrentOrder
    before_filter :setup_current_order
    
    def test_action
      render text: ''
    end
  end

  setup do
    @controller = TestController.new
    @routes.disable_clear_and_finalize = true
    @routes.draw { get 'store/concerns/current_order_test/test/test_action' }
  end

  def current_order
    Order.where(public_id: session["order_id"]).first
  end

  test "put order_id to session" do
    assert session["order_id"].nil?
    get :test_action
    assert session["order_id"].present?
  end

  test "creates order for first visit" do
    get :test_action
    assert current_order.present?
  end

  test "uses created before order" do
    get :test_action
    assert_no_difference 'current_order.id' do
      get :test_action
    end
  end

  test "current_order helper" do
    get :test_action
    assert_equal @controller.send(:current_order).id, current_order.id
    assert @controller._helper_methods.include?(:current_order )
  end

  test "clean_current_order method" do
    get :test_action
    order_id = session[:order_id]
    @controller.send :clean_current_order
    assert session[:order_id].nil?
    assert Order.where(public_id: order_id).first.present?
  end

  test 'clean_current_order generates new order instance on next visit' do
    get :test_action
    assert_difference 'current_order.id' do
      @controller.send :clean_current_order
      get :test_action
    end
  end
end
