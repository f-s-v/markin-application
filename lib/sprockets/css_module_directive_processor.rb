class Sprockets::CSSModuleDirectiveProcessor < Sprockets::DirectiveProcessor
  def process_css_module_directive(module_name)
    @body.gsub!(/%this./, "%#{module_name}-")
    @body.gsub!(/%this/, "%#{module_name}")
    @body.gsub!(/this\./, ".#{module_name}-")
    @body.gsub!(/this/, ".#{module_name}")
  end
end