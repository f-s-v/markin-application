class Translation < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  validates :owner_type, :owner_id, :text, :key, :locale, presence: true
end
