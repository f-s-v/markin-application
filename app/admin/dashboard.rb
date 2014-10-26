ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  action_item :view_site do
    link_to t('.view_site'), root_path
  end

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel t('.recent_orders') do
          table_for Order.completed.includes(:user, shipping_info: :country).recent.limit(5) do
            column(:id) {|c| link_to c.public_id, [:admin, c]}
            column(:total) {|c| number_to_currency c.total, precision: 0}
            column :created_at
            column :user
            column(:country) {|c| c.shipping_info.country.code.upcase}
          end
          span link_to(t('.orders'), [:admin, :orders], class: 'table_tools_button')
        end
      end

      column do
        panel t('.recent_products') do
          table_for Product.recent.limit(5) do
            column(:ID) {|c| link_to c.public_id, [:admin, c]}
            column(:name) {|c| c.name.value}
            column :batch
            column :price do |product|
              number_to_currency product.price, precision: 0
            end
          end
          span link_to(t('.products'), [:admin, :products], class: 'table_tools_button')
          span link_to(t('.create'), new_admin_product_path, class: 'table_tools_button')
        end
      end
    end
    
    columns do
      column do
        panel t('.recent_pages') do
          table_for Page.recent.limit(5) do
            column(:ID) {|c| link_to c.slug, [:admin, c]}
            column(:title) {|c| c.title.value}
          end
          span link_to(t('.pages'), [:admin, :pages], class: 'table_tools_button')
        end
      end
      
      column do
        panel t(".latest_news") do
          table_for Paper.recent.limit(5) do
            column(:id) {|c| link_to c.public_id, [:admin, c]}
            column(:title) {|c| c.title.value }
          end
          span link_to(t('.news'), [:admin, :papers], class: 'table_tools_button')
        end
      end
    end
  end
end
