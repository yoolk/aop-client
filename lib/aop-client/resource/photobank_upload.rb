module AopClient
  module Resource
    class PhotobankUpload
      include ActiveModel::Validations

      ## Attributes
      attr_accessor :extra_context
      attr_accessor :file_name
      attr_accessor :group_id
      attr_accessor :image_bytes

      ## Validations
      validates! :image_bytes,    presence: true
      validates! :group_id,       numericality: { only_integer: true, greater_than: 0 },
                                  allow_blank: true
      validates! :file_name,      presence: true, format: /\A\w+\.(jpeg|jpg|png)\z/
      validates! :extra_context,  'aop_client/comma_key_value' => true,
                                  allow_blank: true

      def initialize(**options)
        options = options.assert_valid_keys(:extra_context, :file_name, :group_id,
          :image_bytes)

        self.group_id      = options[:group_id]
        self.file_name     = options[:file_name]
        self.image_bytes   = options[:image_bytes]
        self.extra_context = options[:extra_context]

        valid?
      end

      def request_params
        hash = { file_name: file_name }
        hash.merge!(group_id: group_id) if group_id.present?
        hash.merge!(extra_context: extra_context) if extra_context.present?

        hash
      end

      def multipart_params
        { image_bytes: image_bytes }
      end

      def require_access_token?
        true
      end

    end
  end
end