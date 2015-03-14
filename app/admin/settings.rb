ActiveAdmin.register Setting do
  menu parent: 'Store'

  actions :all, except: [:destroy, :new, :show]
  config.filters = false

  controller do
    def permitted_params
      params.permit!
    end
  end
  
  form do |f|
    f.input :usd_rub
    f.actions
  end
  
end
