class Message < ActiveRecord::Base
  belongs_to :receiver
  default_scope -> { order('created_at desc') }

  def text
    I18n.t("messages.#{receiver_type.downcase}.#{code}")
  end
end
