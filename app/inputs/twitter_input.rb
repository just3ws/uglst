class TwitterInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    begin
      input_html_options[:class] << wrapper_options[:class]

      out = ActiveSupport::SafeBuffer.new # the output buffer we're going to build
      if twitter_value = object.send("#{attribute_name}")
        out << @builder.hidden_field("#{attribute_name}_cache", value: twitter_value.user_id).html_safe
        out << @builder.text_field(attribute_name, input_html_options.merge({ value: twitter_value.screen_name }))
      else
        out << @builder.text_field(attribute_name, input_html_options)
      end
    rescue => ex
      ap ex

      require 'pry'; binding.pry
    end

    ## Be aware for I18n: translate the "and" here
    #(field1 << @builder.label(:"#{attribute_name}_lteq", 'and', class: 'separator') << field2).html_safe
  end

  # Make the label be for the first of the two fields
  def label_target
    :"#{attribute_name}"
  end
end
