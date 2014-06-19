module Concerns::Letters
  extend ActiveSupport::Concern

  included do 
    cattr_accessor(:letters){ Array.new }
  end

  module ClassMethods
    def let(name, options={}, &block)
      letters << [name, options, block]
      helper_method name
    end
  end

  private def method_missing_with_letters(symbol, *args)
    if self.class.letters.map(&:first).include? symbol
      name, options, block = self.class.letters.find{|a| a.first == symbol}
      on = options[:on]
      if !on || on && (
        on.try(:include?, action_name) ||
        on == action_name ||
        recognize_member_action && on == :member ||
        !recognize_member_action && on == :collection
      )
        return instance_variable_get("@#{name}") || instance_variable_set("@#{name}", instance_eval(&block))
      end
    end
    method_missing_without_letters symbol, *args
  end
  alias_method_chain :method_missing, :letters

  private def recognize_member_action
    params.has_key?(:id)
  end
end
