module FilterParams
  extend ActiveSupport::Concern

  module ClassMethods
    def filter_params params
      params.select{ |k, v| accessible_attributes.include? k }
    end
  end
end
