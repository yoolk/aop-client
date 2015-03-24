module AopClient
  module Resource
    class CategoryAttrvalueGet
      include ActiveModel::Validations

      ## Attributes
      attr_accessor :cat_id
      attr_accessor :attribute_id
      attr_accessor :attribute_value_id

      ## Validations
      validates! :cat_id,   presence: true,
                            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
      validates! :attribute_id,       'aop_client/comma_numeric' => true, allow_blank: true
      validates! :attribute_value_id, 'aop_client/comma_numeric' => true, allow_blank: true

      def initialize(**options)
        options = options.assert_valid_keys(:cat_id, :attribute_id, :attribute_value_id)

        self.cat_id  = options[:cat_id]
        self.attribute_id = options[:attribute_id]
        self.attribute_value_id = options[:attribute_value_id]

        valid?
      end

      def request_params
        hash = { cat_id: cat_id }
        hash.merge!(attribute_id: attribute_id) if attribute_id.present?
        hash.merge!(attribute_value_id: attribute_value_id) if attribute_value_id.present?

        { attribute_value_request: hash.to_json }
      end

      def require_access_token?
        false
      end

    end
  end
end