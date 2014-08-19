module Concerns
  module Translated
    extend ActiveSupport::Concern

    module ClassMethods
      def translated(*attrs)
        attrs.each do |attribute|
          has_many attribute, -> {where(key: attribute)}, class_name: 'Translation', as: 'owner', dependent: :destroy do
            def value(l = nil)
              where(locale: l || I18n.locale).first.try(:text)
            end
          end
          accepts_nested_attributes_for attribute
          # default_scope -> { includes(attribute) }
        end
      end
    end
  end
end