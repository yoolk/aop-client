module AopClient
  module Response
    class PhotobankList < Base
      def data
        return [] if super.nil?

        super[:alibaba_icbu_photobank_list_response][:pagination_query_list][:list][:photobank_image_do]
      end
    end
  end
end
