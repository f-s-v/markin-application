class PagesController < ApplicationController
  inherit_resources
  defaults finder: :find_by_slug!

  def test
    render text: ::PAYMENT_GATEWAY.inspect
  end
end
