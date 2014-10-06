class Translation < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  validates :key, :locale, presence: true
  validates :locale, uniqueness: {scope: [:owner_id, :owner_type, :key]}
end
