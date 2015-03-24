module AopClient
  module Response
    class PhotobankUpload < Base

      def data
        return [] if super.nil?

        super['alibaba_icbu_category_postcat_get_response']['result_list']['post_cat']
      end
    end
  end
end