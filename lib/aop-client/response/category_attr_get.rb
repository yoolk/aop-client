module AopClient
  module Response
    class CategoryAttrGet < Base

      def data
        return [] if super.nil?

        super[:alibaba_icbu_category_attr_get_response][:result_list][:attribute]
      end
    end
  end
end