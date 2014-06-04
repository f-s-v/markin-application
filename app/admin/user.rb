ActiveAdmin.register User do
  actions :all, :except => [:destroy, :new]

  filter :email
  filter :name
  filter :sign_in_count
  filter :current_sign_in_at
  filter :last_sign_in_at
  filter :current_sign_in_ip
  filter :last_sign_in_ip
  filter :created_at

  permit_params :email, :name

  index do
    selectable_column
    column :email do |user|
      link_to user.email, [:admin, user]
    end
    column :name
    actions
  end

  show  do
    attributes_table_for user do
      row :email
      row :name
      row :created_at
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
    end
    f.actions
  end
end
