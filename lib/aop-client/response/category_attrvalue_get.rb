module AopClient
  module Response
    class CategoryAttrvalueGet < Base

      def data
        return [] if super.nil?

        super[:alibaba_icbu_category_attrvalue_get_response][:result_list][:attribute_value]
      end
    end
  end
end