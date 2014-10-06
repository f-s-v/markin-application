class Page < ActiveRecord::Base
  include Concerns::Translated
  translated :title, :description

  include Concerns::ContentBlocks
end
