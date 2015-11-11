begin
  LatteConfig[:schema].keys.each do |controller|

    ##
    # get model by schema key
    model = controller.singularize.camelize.constantize

    if model.translates?
      ##
      # add translated attributes to appropiated schema key
      LatteConfig[:schema][controller] += model.translated_attribute_names.map{ |attr|
        LatteConfig[:languages].map{ |lang| "#{attr}_#{lang}" }
      }.flatten

      ##
      # delete original attributes from appropiated schema key
      LatteConfig[:schema][controller] = LatteConfig[:schema][controller] - model.translated_attribute_names.map(&:to_s)
    end
  end
rescue
  nil
end
