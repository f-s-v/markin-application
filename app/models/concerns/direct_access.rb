module Concerns
  module DirectAccess
    extend ActiveSupport::Concern

    included do
      scope :searchable, -> do
        where(direct_access_only: false)
      end
    end
    
  end
end
