class Mgmt::CharacteristicsController < ApplicationController
  mgmt_resources
  defaults resource_class: ::Product::Characteristic
  layout 'mgmt'
end
