class Mgmt::BatchesController < ApplicationController
  mgmt_resources
  defaults resource_class: ::Product::Batch
end
