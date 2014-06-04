class FormtasticUploadcareInput < Formtastic::Inputs::StringInput
  def input_html_options
    super.merge(role: "uploadcare-uploader", type: 'hidden')
  end
end