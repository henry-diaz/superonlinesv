require 'base64'

module BootstrapForm
  class NestedFormBuilder

    def generate_label(id, name, options, custom_label_col, group_layout)
      options[:class] = options[:class].nil? ? [] : options[:class].split(' ').flatten
      klass = self.object.class
      name  = name.to_sym
      if klass.translates?
        if klass.translated_attribute_names.map{ |attr| LatteConfig[:languages].map{ |lang| "#{attr}_#{lang}" }}.flatten.map(&:to_sym).include?(name)
          if klass.respond_to?(:globalize_validations_locales) &&
            klass.translated_attribute_names.map{ |attr| klass.globalize_validations_locales.map{ |lang| "#{attr}_#{lang}" }}.flatten.map(&:to_sym).include?(name)
            name = name.to_s.gsub(/_(#{klass.globalize_validations_locales.join('|')})$/, '')
            options[:class] << 'required' if required_attribute?(self.object.class, name)
            return unrequired_generate_label(id, name, options, custom_label_col, group_layout)
          else
            name = name.to_s.gsub(/_(#{LatteConfig[:languages].join('|')})$/, '')
            return unrequired_generate_label(id, name, options, custom_label_col, group_layout)
          end
        end
      end
      super(id, name, options, custom_label_col, group_layout)
    end


    def unrequired_generate_label(id, name, options, custom_label_col, group_layout)
      options[:for] = id if acts_like_form_tag
      classes = [options[:class], label_class]
      classes << (custom_label_col || label_col) if get_group_layout(group_layout) == :horizontal
      options[:class] = classes.compact.join(" ")
      if label_errors && has_error?(name)
        error_messages = get_error_messages(name)
        label_text = (options[:text] || object.class.human_attribute_name(name)).to_s.concat(" #{error_messages}")
        label(name, label_text, options.except(:text))
      else
        label(name, options[:text], options.except(:text))
      end
    end

    def tags_field(name, options = {})
      options.reverse_merge!(value: self.object.send(name).to_s, data: { role: 'tags' })
      form_group_builder(name, options.reverse_merge(control_class: nil)) do
        text_field_without_bootstrap(name, options)
      end
    end

    def cktext_area(method, options = {})
      form_group_builder(method, options.reverse_merge(control_class: nil)) do
        super(method, options)
      end
    end

    def field_set(record_name, &block)
      if LatteConfig[:schema][self.object.class.name.pluralize.underscore].include?(record_name.to_s)
        content_tag(:fieldset, id: record_name) do
          content_tag :legend do
            I18n.t("activerecord.models.#{record_name.to_s.singularize}", count: :many)
          end.concat(
            capture(&block).to_s
          )
        end
      end
    end

    def fields_for(record_name, record_object = nil, fields_options = {}, &block)
      if LatteConfig[:schema][self.object.class.name.pluralize.underscore].include?(record_name.to_s)
        super(record_name, record_object, fields_options, &block)
      end
    end

    def form_group_builder(method, options, html_options = nil)
      if LatteConfig[:schema][self.object.class.name.pluralize.underscore].include?(method.to_s)
        super(method, options, html_options)
      end
    end

    def form_group(*args, &block)
      if LatteConfig[:schema][self.object.class.name.pluralize.underscore].include?(args.first.to_s)
        super(*args, &block)
      end
    end

    def file_field_cleaner(name, options = {})
      content_tag(:button, type: 'button', class: "btn btn-default #{options[:previewer]}-preview-clear", style: "display: #{self.object.send(name).present? ? '' : 'none'}") do
        [content_tag(:span, '', class: 'glyphicon glyphicon-remove'), I18n.t('file_field.clear')].join(' ').html_safe
      end
    end

    def file_field_download(name, options = {})
      if self.object.send(name).exists?
        content_tag(:span, class: 'input-group-btn') do
          content_tag :a, href: self.object.send(name).url, target: '_blank', class: 'btn btn-default' do
            content_tag(:span, '', class: 'glyphicon glyphicon-download-alt')
          end
        end
      end
    end

    def file_field_input(name, options = {})
      content_tag :div, class: "btn btn-default #{options[:previewer]}-preview-input" do
        [content_tag(:span, '', class: 'glyphicon glyphicon-folder-open'), file_field_without_bootstrap(name, options)].join.html_safe
      end
    end

    def file_field(name, options = {})
      options.reverse_merge!(previewer: :datafile)
      form_group_builder(name, options.reverse_merge(control_class: nil)) do
        content_tag :div, class: "input-group #{options[:previewer]}-preview", data: { missing: self.object.class.new.send(name).url, src: self.object.send(name).try(:url) } do
          [
            file_field_download(name, options),
            hidden_field("delete_#{name}".to_sym, { value: self.object.send("delete_#{name}") }),
            text_field_without_bootstrap(name, name: nil, class: "form-control #{options[:previewer]}-preview-filename", disabled: true, value: self.object.send("#{name}_file_name")),
            content_tag(:span, class: 'input-group-btn') do
              [
                file_field_cleaner(name, options),
                file_field_input(name, options)
              ].join.html_safe
            end
          ].join.html_safe
        end
      end
    end

    def image_file_field(name, options = {})
      options.reverse_merge!(accept: 'image/*', previewer: :image)
      file_field(name, options)
    end
  end
end
