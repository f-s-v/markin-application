Rails.application.config.instance_eval do |config|
  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  config.assets.precompile += [
    'active_admin.css', 'active_admin.js',
    'fullpicture.html',
    'fullpicture-manage.html',
  ]

  config.assets.paths << "#{Rails.root}/app/assets/fonts"
  config.assets.paths << "#{Rails.root}/vendor/components"
end
