class FixContentblocksOrders < ActiveRecord::Migration
  def up
    [Page, Product].each do |model|
      model.all.each do |object|
        object.content_blocks.ordered.each_with_index do |block, index|
          block.update_attributes order_number: index
        end
      end
    end
  end
end
