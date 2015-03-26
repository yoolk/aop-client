module AopClient
  module Resource
    class OpenProductPost < Base
      ## Attributes
      attr_accessor :group_id
      attr_accessor :keywords
      attr_accessor :subject
      attr_accessor :description
      attr_accessor :category_id
      attr_accessor :product_image
      attr_accessor :properties
      attr_accessor :product_id
      attr_accessor :extra_context

      ## Validations
      validates! :keywords,     presence: true
      validates! :subject,      presence: true
      validates! :product_image, presence: true
      validates! :category_id,  presence: true, numericality:
                                { only_integer: true, greater_than_or_equal_to: 0 }
      validates! :product_id,   numericality: { only_integer: true, greater_than: 0 },
                                allow_blank: true

      def initialize(**options)
        options = options.assert_valid_keys(
          :group_id, :keywords, :subject, :description, :category_id,
          :product_image, :properties, :product_id, :extra_context
        )

        self.group_id      = options[:group_id]
        self.keywords      = options[:keywords]
        self.subject       = options[:subject]
        self.description   = options[:description]
        self.category_id   = options[:category_id]
        self.product_image = options[:product_image]
        self.properties    = options[:properties]
        self.product_id    = options[:product_id]
        self.extra_context = options[:extra_context]

        valid?
      end

      def request_params
        hash = {
          subject: subject,
          keywords: keywords,
          category_id: category_id,
          product_image: product_image
        }

        hash.merge!(description: description) if description.present?
        hash.merge!(group_id: group_id) if group_id.present?
        hash.merge!(extra_context: extra_context) if extra_context.present?
        hash.merge!(product_id: product_id) if product_id.present?
        hash.merge!(properties: properties) if properties.present?

        { param_product_post: hash.to_json }
      end

      def require_access_token?
        true
      end
    end
  end
end
