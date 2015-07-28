ActiveAdmin.register User do
  actions :all, :except => [:destroy, :new]

  filter :email
  filter :name
  filter :created_at

  permit_params :email, :name, :password, :password_confirmation

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
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
