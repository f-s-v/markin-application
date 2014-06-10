require 'sprockets/css_module_directive_processor'
Rails.application.assets.unregister_processor('text/css', Sprockets::DirectiveProcessor)
Rails.application.assets.register_processor('text/css', Sprockets::CSSModuleDirectiveProcessor)
