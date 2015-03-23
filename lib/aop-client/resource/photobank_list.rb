module AopClient
  module Resource
    class PhotobankList
      include ActiveModel::Validations

      ## Attributes
      attr_accessor :extra_context
      attr_accessor :current_page
      attr_accessor :group_id
      attr_accessor :location_type
      attr_accessor :page_size

      ## Validations
      validates! :current_page,   numericality: { only_integer: true, greater_than: 0 },
                                  allow_blank: true
      validates! :page_size,      numericality: { only_integer: true, greater_than: 0 },
                                  allow_blank: true
      validates! :group_id,       numericality: { only_integer: true, greater_than: 0 },
                                  allow_blank: true
      validates! :location_type,  inclusion: %w(ALL_GROUP SUB_GROUP UNGROUP),
                                  allow_blank: true
      validates! :extra_context,  'aop_client/comma_key_value' => true,
                                  allow_blank: true

      def initialize(**options)
        options = options.assert_valid_keys(:extra_context, :current_page, :group_id,
          :location_type, :page_size)

        self.group_id      = options[:group_id]
        self.page_size     = options[:page_size]
        self.current_page  = options[:current_page]
        self.extra_context = options[:extra_context]
        self.location_type = options[:location_type]

        valid?
      end

      def request_params
        hash = {}
        hash.merge!(group_id: group_id) if group_id.present?
        hash.merge!(page_size: page_size) if page_size.present?
        hash.merge!(current_page: current_page) if current_page.present?
        hash.merge!(extra_context: extra_context) if extra_context.present?
        hash.merge!(location_type: location_type) if location_type.present?

        hash
      end

    end
  end
end