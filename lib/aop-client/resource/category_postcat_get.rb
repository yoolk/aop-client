module AopClient
  module Resource
    class CategoryPostcatGet < Base
      ## Attributes
      attr_accessor :cat_id

      ## Validations
      validates! :cat_id, presence: true,
                          numericality: { only_integer: true, greater_than_or_equal_to: 0 }

      def initialize(**options)
        options = options.assert_valid_keys(:cat_id)

        self.cat_id = options[:cat_id]

        valid?
      end

      def request_params
        hash = { cat_id: cat_id }

        { post_cat_request: hash.to_json }
      end

    end
  end
end