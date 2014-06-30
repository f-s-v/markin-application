class OrderMailer < ActionMailer::Base
  default from: "info@vladimirmarkin.com"

  def created(order)
    @order = order
    mail to: order.user.email
  end
end
