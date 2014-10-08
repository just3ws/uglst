class TwitterInput < SimpleForm::Inputs::Base
  def input
    require 'pry'; binding.pry
    input_html_options[:class] << :'form-control'

    out = ActiveSupport::SafeBuffer.new # the output buffer we're going to build
    out << @builder.hidden_field("#{attribute_name}_cache", value: object.send("#{attribute_name}").user_id).html_safe
    out << @builder.text_field(attribute_name, input_html_options.merge({ value: object.send("#{attribute_name}").screen_name }))

    ## Be aware for I18n: translate the "and" here
    #(field1 << @builder.label(:"#{attribute_name}_lteq", 'and', class: 'separator') << field2).html_safe
  end

  # Make the label be for the first of the two fields
  def label_target
    :"#{attribute_name}"
  end
end
