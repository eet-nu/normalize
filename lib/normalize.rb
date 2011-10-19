require 'active_support/concern'

module Normalize
  extend ActiveSupport::Concern
  
  def normalize_value(value, normalizer)
    normalizer.call(value)
  end
  
  module ClassMethods
    def normalize(attribute, options)
      normalizer = extract_normalizer(options)
      
      class_eval do
        if method_defined? "#{attribute}="
          define_method "#{attribute}_with_normalizer=" do |value|
            send("#{attribute}_without_normalizer=", normalize_value(value, normalizer))
          end
          alias_method_chain "#{attribute}=", :normalizer
        else
          define_method "#{attribute}=" do |value|
            super(normalize_value(value, normalizer))
          end
        end
      end
    end
    
    def extract_normalizer(options_or_normalizer)
      if options_or_normalizer.respond_to?(:[])
        options_or_normalizer[:with]
      else
        options_or_normalizer
      end
    end
  end
end

require 'active_record'
ActiveRecord::Base.send(:include, Normalize)
