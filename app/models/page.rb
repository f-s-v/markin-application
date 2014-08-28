class Page < ActiveRecord::Base
  include Concerns::Translated
  translated :title

  include Concerns::ContentBlocks
end
