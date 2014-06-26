class PagesController < ApplicationController
  inherit_resources
  defaults finder: :find_by_slug!
end
