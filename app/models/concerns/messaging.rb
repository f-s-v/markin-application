module Concerns
  module Messaging
    extend ActiveSupport::Concern

    included do
      has_many :messages, as: :receiver
    end

    def send_message(code)
      messages.create(code: code)
    end
  end
end