module Concerns
  module PublicId
    extend ActiveSupport::Concern

    module ClassMethods
      def generates_public_id(attr)
        before_validation(on: :create) do
          self.send "#{attr}=", self.class.generate_public_id(attr)
        end
      end

      def generate_public_id(attr)
        number = -> (digits) { rand(10 ** digits).to_s.rjust(digits, '0') }
        begin
          token = number.call(9).chars.each_slice(3).map(&:join).join('-')
        end while where(attr => token).count > 0
        token
      end
    end
  end
end