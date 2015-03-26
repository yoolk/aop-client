module AopClient
  module Response
    class OpenProductPost < Base
      def data
        return {} if super.nil?

        super[:alibaba_icbu_open_product_post_response]
      end
    end
  end
end
