module AopClient
  module Resource
    class CategoryAttrGet < Base
      ## Attributes
      attr_accessor :cat_id
      attr_accessor :attr_id

      ## Validations
      validates! :cat_id,   presence: true,
                            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
      validates! :attr_id,  'aop_client/array_id' => true, allow_blank: true

      def initialize(**options)
        options = options.assert_valid_keys(:cat_id, :attr_id)

        self.cat_id  = options[:cat_id]
        self.attr_id = options[:attr_id]

        valid?
      end

      def request_params
        hash = { cat_id: cat_id }
        hash.merge!(attr_id: attr_id) if attr_id.present?

        { attribute_request: hash.to_json }
      end

    end
  end
end