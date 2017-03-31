require "active_support/concern"
require "human_attribute_value/version"

module HumanAttributeValue
  extend ActiveSupport::Concern

  included do
    extend ActiveModel::Translation unless self.is_a?(ActiveModel::Translation)
  end

  class_methods do
    # adapted from activemodel-5.0.0/lib/active_model/translation.rb
    def human_attribute_value(attribute, value, options = {})
      options   = { count: 1 }.merge!(options)
      parts     = attribute.to_s.split(".")
      attribute = parts.pop
      namespace = parts.join("/") unless parts.empty?
      values_scope = "#{self.i18n_scope}.values"

      if namespace
        defaults = lookup_ancestors.map do |klass|
          :"#{values_scope}.#{klass.model_name.i18n_key}/#{namespace}.#{attribute}.#{value}"
        end
        defaults << :"#{values_scope}.#{namespace}.#{attribute}.#{value}"
      else
        defaults = lookup_ancestors.map do |klass|
          :"#{values_scope}.#{klass.model_name.i18n_key}.#{attribute}.#{value}"
        end
      end

      defaults << :"values.#{attribute}.#{value}"
      defaults << options.delete(:default) if options[:default]
      defaults << value.try(:humanize) || value

      options[:default] = defaults
      I18n.translate(defaults.shift, options)
    end
  end

  def human_attribute_value(attribute, options = {})
    value = public_send(attribute)

    if value.present?
      if value.is_a?(Array)
        value.map { |el| self.class.human_attribute_value(attribute, el, options) }
      else
        self.class.human_attribute_value(attribute, value, options)
      end
    end
  end
end
