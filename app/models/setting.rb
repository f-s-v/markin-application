class Setting < ActiveRecord::Base
  def self.usd_rub
    self.last.usd_rub
  end

  def self.currency_code
    if (I18n.locale == :ru) && self.usd_ruby.present?
      'RUB'
    else
      'USD'
    end
  end

end
